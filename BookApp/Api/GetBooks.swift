//
//  GetBooks.swift
//  BookApp
//
//  Created by Revan Sadigli on 31.03.2023.
//

import Foundation

class GetBooks: NSObject {
    
    static let shared: GetBooks = GetBooks()
    
    private let method = "newBook"
    
    public var cacheData: BookModel?
    
    func fetch(completion: ((BookModel) -> Void)? = nil) {
        
        let param = BookModelRequest()
        print("test")
        WebService.shared.fetch(method, parameter: param) { (response: BookModel) in
            print("test1")

            self.cacheData = response
            completion?(response)
        }
        
    }
}
