//
//  BookModel.swift
//  BookApp
//
//  Created by Revan Sadigli on 31.03.2023.
//

import Foundation


struct BookModelRequest: Encodable {
}

struct BookModel: Decodable {
    var success: Bool
    var books: [BookInfo]
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case books = "result"
    }
    
    init(succes: Bool, books: [BookInfo]) {
        self.success = succes
        self.books = books
    }
}

// MARK: - Result
struct BookInfo: Decodable, Identifiable {
    var id = UUID()
    var category = categories.randomElement()
    var url: String
    var discount, price, publisher, author: String
    var title: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case discount = "indirim"
        case price = "fiyat"
        case publisher = "yayın"
        case author = "yazar"
        case title
        case image
    }
    
    init(url: String, discount: String, price: String, publisher: String, author: String, title: String, image: String) {
        self.url = url
        self.discount = discount
        self.price = price
        self.publisher = publisher
        self.author = author
        self.title = title
        self.image = image
    }
}

private let categories = ["All", "Crime", "Horror", "Thriller", "Classic", "Science"]
