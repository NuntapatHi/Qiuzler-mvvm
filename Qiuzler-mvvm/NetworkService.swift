//
//  NetworkService.swift
//  Qiuzler-mvvm
//
//  Created by Nuntapat Hirunnattee on 17/9/2565 BE.
//

import Foundation

struct NetworkService{
    
    static let shared = NetworkService()
    
    private init(){ }
    
    func request<T: Codable>(with url: String, type: T.Type, completion: @escaping (T?, Error?) -> Void){
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }
            
            do{
                let safeData = try JSONDecoder().decode(type, from: data)
                completion(safeData, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
