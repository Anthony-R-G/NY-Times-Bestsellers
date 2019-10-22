//
//  NewYorkTimesBooksAPIClient.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/21/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

final class NYTimesBookAPIClient {
    private init() {}
    private var apiKey = "Ge7O8fEFdUuSujd9AldzIIZQjV0cx1GI"
    static let shared = NYTimesBookAPIClient()
    
    func getBooks(categoryName: String, completionHandler: @escaping (Result<[NYTimeBook], AppError>) -> Void) {
   let urlStr = "https://api.nytimes.com/svc/books/v3/lists/current/\(categoryName).json?api-key=\(apiKey)"
        
         guard let url = URL(string: urlStr) else {
             completionHandler(.failure(.badURL))
             return
         }
         
         NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
             switch result {
             case .failure(let error) :
                 completionHandler(.failure(error))
             case .success(let data):
                 do {
                     let NYTimeWrapper = try JSONDecoder().decode(NYTimeBookWrapper.self, from: data)
                    completionHandler(.success(NYTimeWrapper.results.books))
                 } catch {
                     completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                 }
             }
         }
     }
}
