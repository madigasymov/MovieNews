//
//  Movie.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/12/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let backdropPath: String
    let voteAverage: Double
    var isFavorite: Bool
    
    init?(movieData: MovieData) {
        id = movieData.id
        title = movieData.original_title
        overview = movieData.overview
        releaseDate = movieData.release_date
        backdropPath = movieData.backdrop_path
        voteAverage = movieData.vote_average
        isFavorite = false
    }
}
