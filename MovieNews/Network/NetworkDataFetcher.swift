//
//  NetworkDataFetcher.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/11/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import UIKit

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchMovie(urlString: String, completion: @escaping (Page?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(Page.self, from: data)
            completion(response)
        }
    }
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        networkService.request(urlString: urlString) { (data, error) in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
    }
}
