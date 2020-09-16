//
//  NewsController.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/9/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class NewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private var networkDataFetcher = NetworkDataFetcher()
    var movies = [Movie]()
    private var refresher: UIRefreshControl!
    private var pageNumber = 1
    let cache = NSCache<NSString, NSArray>()
    let cachePage = NSCache<NSString, NSString>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = Const.Color.blue
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView.backgroundColor = Const.Color.darkBlue
        collectionView.alwaysBounceVertical = true
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        
        refresher = UIRefreshControl()
        refresher.tintColor = .lightGray
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.refreshControl = refresher
        
        fetchFromCache()
    }
}

extension NewsController {
    
    // MARK: Methods
    
    private func fetchFromCache() {
        if let cachedData = cache.object(forKey: "CachedMovieNews") {
            movies = cachedData as! [Movie]
            collectionView.reloadData()
        } else {
            if let cachedPage = cachePage.object(forKey: "CachedPageNumber") {
                pageNumber = Int(cachedPage as String) ?? 1
            } else {
                pageNumber = 1
            }
            fetchMovies()
        }
    }
    
    private func fetchMovies() {
        let url = Const.URL.moviesURL + "\(pageNumber)"
        networkDataFetcher.fetchMovie(urlString: url) { (page) in
            let results = page?.results
            results?.forEach({ (item) in
                self.movies.append(Movie(movieData: item)!)
            })
            self.cache.setObject(self.movies as NSArray, forKey: "CachedMovieNews")
            self.cachePage.setObject("\(self.pageNumber)" as NSString, forKey: "CachedPageNumber")
            self.collectionView.reloadData()
        }
    }
    
    @objc private func loadData() {
        collectionView.refreshControl?.beginRefreshing()
        movies.removeAll()
        fetchFromCache()
        collectionView.refreshControl?.endRefreshing()
    }
    
    @objc func checkAsFavorite(sender: UIButton) {
        movies[sender.tag].isFavorite = movies[sender.tag].isFavorite ? false : true
        sender.isSelected = sender.isSelected ? false : true
        sender.tintColor = sender.isSelected ? Const.Color.yellow : .black
    }
    
    // MARK: CollectionView setiings
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            pageNumber += 1
            fetchMovies()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsDetailController = NewsDetailController()
        newsDetailController.delegate = self
        newsDetailController.movieIndex = indexPath
        newsDetailController.movieTitle = movies[indexPath.item].title
        newsDetailController.movieDetailView.movie = movies[indexPath.item]
        navigationController?.pushViewController(newsDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.movie = movie
        cell.starButton.tag = indexPath.item
        cell.starButton.addTarget(self, action: #selector(checkAsFavorite(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
        })
    }
}
