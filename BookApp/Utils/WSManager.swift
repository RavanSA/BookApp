//
//  WSManager.swift
//  BookApp
//
//  Created by Revan Sadigli on 31.03.2023.
//

import Foundation
import SwiftUI


public class WebService: NSObject {
    
    public static let shared: WebService = WebService()
    
    
    public func fetch<T1: Encodable, T2: Decodable>(_ method: String!, parameter: T1, completion: ((T2) -> Void)? = nil) {
        
        let webService = "https://api.collectapi.com/book"
        
        guard let url = URL(string: "\(webService)/\(method!)") else {return}
        
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONManager().encoder.encode(parameter)
        urlRequest.addValue("apikey xxxxxxxxxxxxxx", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response , error in
            
            
            if let error = error {
                showMessage(error.localizedDescription, title: "Error Occured")
            }
            
            guard let data = data else {return}
            let httpResponse = response as? HTTPURLResponse
            
            do {
                
                let decoded = try JSONManager().decoder.decode(T2.self, from: data)
                
                completion?(decoded )
            } catch let error {
                showMessage(error.localizedDescription, title: "Error Occured")
                
                return
            }
            
        }.resume()
    }
    
}
