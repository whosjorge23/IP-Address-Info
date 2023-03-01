//
//  APIManager.swift
//  IP Address Info
//
//  Created by Giorgio Giannotta on 25/02/23.
//

import SwiftUI

class APIManager: ObservableObject {
    // Generic fetch API data function
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                // If there is an error, return the error.
                if let error = error { failure(error) }
                return }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                // Return the data successfully from the server
                completion((serverData))
            } catch {
                // If there is an error, return the error.
                failure(error)
            }
        }.resume()
    }
}
