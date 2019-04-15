//
//  Services.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import Foundation

struct NetworkingService {
    static let shared = NetworkingService()
    
    func getRequest<T: Decodable>(urlString: String, completion: @escaping ([T]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let homeFeed = try decoder.decode(Array<T>.self, from: data)
                
                DispatchQueue.main.async {
                    completion(homeFeed)
                }
            } catch let jsonErr {
                print("Failed to serialize JSON:", jsonErr)
            }
            
            }.resume()
    }
}
