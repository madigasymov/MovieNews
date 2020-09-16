//
//  Constants.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/11/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class Const {
    
    static let apiKey = "f013a343448b466994d3648a4b30b763"
    
    struct URL {
        static let baseURL = "https://api.themoviedb.org/3"
        static let moviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(Const.apiKey)&language=en-US&page="
        static let imageURL = "https://image.tmdb.org/t/p/original"
        
    }
    
    struct Color {
        static let darkBlue = UIColor(red: 13/255, green: 37/255, blue: 63/255, alpha: 1.0)
        static let blue = UIColor(red: 27/255, green: 68/255, blue: 98/255, alpha: 1.0)
        static let yellow = UIColor(red: 234/255, green: 196/255, blue: 60/255, alpha: 1.0)
    }
}
