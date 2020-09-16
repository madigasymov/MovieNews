//
//  MovieDetail.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/13/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class MovieDetail: UIView {
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.title
            overviewTextView.text = movie.overview
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
        let image = UIImage(systemName: "film")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.numberOfLines = 2
        label.font = UIFont(name: "Arial-BoldMT", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "ArialMT", size: 18)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
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
    
    var portraitConstraints: [NSLayoutConstraint] = []
    var lanscapeConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = Const.Color.darkBlue
        
        addSubview(backdropImageView)
        portraitConstraints.append(backdropImageView.topAnchor.constraint(equalTo: topAnchor))
        portraitConstraints.append(backdropImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        portraitConstraints.append(backdropImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        portraitConstraints.append(backdropImageView.heightAnchor.constraint(equalTo: widthAnchor))
        
        lanscapeConstraints.append(backdropImageView.topAnchor.constraint(equalTo: topAnchor))
        lanscapeConstraints.append(backdropImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        lanscapeConstraints.append(backdropImageView.bottomAnchor.constraint(equalTo: bottomAnchor))
        lanscapeConstraints.append(backdropImageView.widthAnchor.constraint(equalTo: heightAnchor))

        addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -20).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: backdropImageView.trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8).isActive = true

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

        addSubview(overviewTextView)
        portraitConstraints.append(overviewTextView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor))
        portraitConstraints.append(overviewTextView.leadingAnchor.constraint(equalTo: leadingAnchor))
        portraitConstraints.append(overviewTextView.trailingAnchor.constraint(equalTo: trailingAnchor))
        portraitConstraints.append(overviewTextView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        lanscapeConstraints.append(overviewTextView.topAnchor.constraint(equalTo: topAnchor))
        lanscapeConstraints.append(overviewTextView.leadingAnchor.constraint(equalTo: backdropImageView.trailingAnchor))
        lanscapeConstraints.append(overviewTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        lanscapeConstraints.append(overviewTextView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        setupConstraints()
    }
    
    func setupConstraints() {
        if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact) {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(lanscapeConstraints)
        }
        else {
            NSLayoutConstraint.deactivate(lanscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        }
    }
}
