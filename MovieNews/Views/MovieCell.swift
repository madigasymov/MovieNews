//
//  MovieCell.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/10/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.title
            dateLabel.text = movie.releaseDate
            ratingLabel.text = String(format: "%.1f", movie.voteAverage)
            let imageURL = Const.URL.imageURL + movie.backdropPath
            networkDataFetcher.fetchImage(urlString: imageURL, completion: { (image) in
                self.backdropImageView.image = image
            })
            starButton.isSelected = movie.isFavorite ? true : false
            starButton.tintColor = starButton.isSelected ? Const.Color.yellow : .black
        }
    }
    
    let backdropImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 44
        imageView.alpha = 0.5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont(name: "Arial-BoldMT", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "Arial-BoldMT", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 1
        label.layer.cornerRadius = 24
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.font = UIFont(name: "Arial-BoldMT", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 4)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(backdropImageView)
        backdropImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        backdropImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        backdropImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        backdropImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        backdropImageView.image = UIImage(systemName: "film")
        
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: backdropImageView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: backdropImageView.widthAnchor).isActive = true
        
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: backdropImageView.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: backdropImageView.widthAnchor).isActive = true
        
        addSubview(ratingLabel)
        ratingLabel.topAnchor.constraint(equalTo: backdropImageView.topAnchor, constant: 20).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 20).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 48).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(starButton)
        starButton.topAnchor.constraint(equalTo: backdropImageView.topAnchor, constant: 20).isActive = true
        starButton.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor, constant: -20).isActive = true
        starButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        starButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
