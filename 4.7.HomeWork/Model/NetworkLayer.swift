//
//  NetworkLayer.swift
//  4.7.HomeWork
//
//  Created by anjella on 20/1/23.
//

import Foundation

enum HTTPRequest: String {
case DELETE, POST, GET, PUT
    
    var title: String {
        switch self  {
        case .DELETE:
            return "DELETE"
        case .POST:
            return "POST"
        case .GET:
            return "GET"
        case .PUT:
            return "PUT"
        }
    }
}


enum CustomError: Error {
    case wowError
}

class NetworkLayer {
    static let shared = NetworkLayer()

    var baseUrl = URL(string: "https://dummyjson.com/products")!
    
    func deleteUser(by id: Int) {
       var request = URLRequest(url: baseUrl.appendingPathComponent("\(id)"))
        request.httpMethod = HTTPRequest.DELETE.rawValue

        let task = URLSession(configuration: .default)
            .dataTask(with: request) { data, response, error in
            
                if let error = error {
                    print("Error is \(error.localizedDescription)")
                }
                print(response)
           }
        task.resume()
    }
    
    func createProduct(with model: ProductDataModel) {
        var request = URLRequest(url: baseUrl.appendingPathComponent("add"))
        request.httpMethod = "POST"
        request.httpBody = encodeData(model)
        
        let task = URLSession(configuration: .default)
            .dataTask(with: request) { data, response, error in
               
                if let error = error {
                    print("Error is \(error.localizedDescription)")
                }
                print(String(data: data!, encoding: .utf8))
            }
        task.resume()
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductDataModel], Error>) -> Void) {
        let request = URLRequest(url: baseUrl)
        let task = URLSession(configuration: .default)
            .dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print("Error is \(error.localizedDescription)")
                    completion(.failure(error))
                }
                guard let model = self.decodeData(from: data) else {
                    return
                }
                
                completion(.success(model.products))
            }
        task.resume()
        print("Our request is", request)
    }
        
    private func decodeData(from data: Data?) -> Products? {
        guard let data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Products.self, from: data)
    }
    
    private func encodeData(_ user: ProductDataModel) -> Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(user)
    }
}
