//
//  ErrorManager.swift
//  BookApp
//
//  Created by Revan Sadigli on 31.03.2023.
//

import Foundation
import UIKit

func showMessage(_ message: String, title: String?) {
    DispatchQueue.main.async { () -> Void in
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        if let view = UIApplication.shared.keyWindow?.rootViewController {
            view.present(alert, animated: true)
        }
    }
}
