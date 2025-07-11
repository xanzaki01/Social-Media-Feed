//
//  NetworkServices.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 09/07/25.
//

import Foundation

class NetworkServices {
    static let shared = NetworkServices()
    
    func fetchPost(completion: @escaping ([PostModel]) -> Void){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        URLSession.shared.dataTask(with: url){ data, _, error in
            guard let data = data else { return }
            let posts = try? JSONDecoder().decode([PostModel].self, from: data)
            DispatchQueue.main.async {
                completion(posts ?? [])
            }
        }.resume()
    }
    
}
