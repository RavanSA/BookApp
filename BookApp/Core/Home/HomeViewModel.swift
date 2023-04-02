//
//  HomeViewModel.swift
//  BookApp
//
//  Created by Revan Sadigli on 31.03.2023.
//

import Foundation


@MainActor class HomeViewModel : ObservableObject {
    
    @Published var result = [BookInfo]()
    @Published var popularBooks = [BookInfo]()
    @Published var filteredBooks = [BookInfo]()
    @Published var bestBooks = [BookInfo]()
    
    
    init() {
        getBooks()
    }
    
    func getBooks(categories: String = "All") {
        GetBooks.shared.fetch() { (book) in
            if categories == "All" {
                self.result = book.books
                self.bestBooks = book.books
            } else {
                self.result = book.books.filter { book in
                    return book.category == categories
                  }
                self.bestBooks = self.result
            }
            self.selectPopularBooks()
        }
    }
    
    func selectPopularBooks() {
        self.popularBooks = result.suffix(5)
    }
    
}
