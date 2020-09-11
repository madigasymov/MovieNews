//
//  Movie.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/10/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let backdropPath: String
    let voteAverage: Double
    var isFavorite: Bool
}
