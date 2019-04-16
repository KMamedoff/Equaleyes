//
//  Services.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingService {
    static let shared = NetworkingService()
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        AF.request(urlString, method: .get).validate(statusCode: 200..<300).response { response in
            
            guard response.error == nil else {
                print("Error calliing on \(urlString)")
                return
            }
            
            guard let data = response.data else {
                print("There was an error with the data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let model = try decoder.decode(T.self, from: data)
                
                completion(model)
            } catch let jsonErr {
                print("Failed to decode, \(jsonErr)")
            }
            
        }
    }
}
