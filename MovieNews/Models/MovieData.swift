//
//  MovieData.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/12/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import Foundation

struct Page: Decodable {
    let page: Int
    let results: [MovieData]
}

struct MovieData: Decodable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let backdrop_path: String
    let vote_average: Double
}
