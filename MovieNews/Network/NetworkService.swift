//
//  NetworkService.swift
//  MovieNews
//
//  Created by Rustem Madigassymov on 9/11/20.
//  Copyright © 2020 Rustem Madigassymov. All rights reserved.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = dataTask(from: request, completion: completion)
        task.resume()
    }

    private func dataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
