//
//  NYTimesBookAPIClient.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

final class NYTimesCategoriesAPIClient {
    private init() {}
    
    private var apiKey = "Ge7O8fEFdUuSujd9AldzIIZQjV0cx1GI"
    static let shared = NYTimesCategoriesAPIClient()
    
    func getCategories(completionHandler: @escaping (Result<[ListNameResult], AppError>) -> Void) {
         let urlStr = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=D8XGY4XP3kgNv2V9li2f192mdAOKesVe"
         
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
                     let ListNameResultWrapper = try JSONDecoder().decode(NYTListName.self, from: data)
                    completionHandler(.success(ListNameResultWrapper.results))
                 } catch {
                     completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                 }
             }
         }
     }
}
