//
//  NewsDetailController.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/13/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class NewsDetailController: UIViewController {
    
    var movieDetailView: MovieDetail { return self.view as! MovieDetail }
    weak var delegate: NewsController!
    var movieIndex: IndexPath!
    
    var movieTitle: String? {
        didSet {
            guard let title = movieTitle else { return }
            navigationItem.title = title
        }
    }
    
    override func loadView() {
        self.view = MovieDetail(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailView.starButton.tag = movieIndex.item
        movieDetailView.starButton.addTarget(self, action: #selector(checkAsFavorite(sender:)), for: .touchUpInside)
    }
    
    @objc private func checkAsFavorite(sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
        sender.tintColor = sender.isSelected ? Const.Color.yellow : .black
        delegate.movies[movieIndex.item].isFavorite = movieDetailView.starButton.isSelected
        delegate.collectionView.reloadItems(at: [movieIndex])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.movieDetailView.setupConstraints()
        })
    }
}
