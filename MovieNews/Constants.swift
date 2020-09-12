//
//  Constants.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/11/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import Foundation

class Const {
    
    static let apiKey = "f013a343448b466994d3648a4b30b763"
    
    struct URL {
        static let baseURL = "https://api.themoviedb.org/3"
        static let moviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(Const.apiKey)&language=en-US&page=1"
        static let imageURL = "https://image.tmdb.org/t/p/original"
        
    }
}
