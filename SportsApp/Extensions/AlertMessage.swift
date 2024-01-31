//
//  AlertMessage.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 03/01/2024.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default))
        self.present(alert, animated: true)
    }
}
