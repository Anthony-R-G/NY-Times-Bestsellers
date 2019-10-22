//
//  FavoriteBooksPersistenceHelper.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

struct FavoriteBookPersistenceHelper {
    
    static let manager = FavoriteBookPersistenceHelper()

    func save(newBook: FavoritedBook) throws {
        try persistenceHelper.save(newElement: newBook)
    }

    func getBooks() throws -> [FavoritedBook] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteBook(specificID: Int) throws {
        do {
            let books = try getBooks()
            let newBooks = books.filter { $0.id != specificID}
            try persistenceHelper.replace(elements: newBooks)
        }
    }

    private let persistenceHelper = PersistenceHelper<FavoritedBook>(fileName: "mySavedBooks.plist")
    
    private init() {}
}

