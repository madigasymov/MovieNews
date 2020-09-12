//
//  NewsController.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/9/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class NewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let darkBlue = UIColor(red: 13/255, green: 37/255, blue: 63/255, alpha: 1.0)
    private let cellId = "cellId"
    private var networkDataFetcher = NetworkDataFetcher()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        collectionView.backgroundColor = darkBlue
        collectionView.alwaysBounceVertical = true
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        
        networkDataFetcher.fetchMovie(urlString: Const.URL.moviesURL) { (page) in
            let results = page?.results
            results?.forEach({ (item) in
                self.movies.append(Movie(movieData: item)!)
            })
        }
        print(movies.first?.title)

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

