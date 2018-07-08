//
//  EnumClass.swift
//  CodableDemoProject
//
//  Created by Dipak on 31/05/18.
//  Copyright © 2018 Dipak. All rights reserved.
//

import UIKit

class EnumClass: NSObject {
    
    static let sharedEnum = EnumClass()

    // MARK: - Show Alert Message
    
    func showAlert(message:String) -> UIAlertController {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
        }
        actionSheetController.addAction(nextAction)
        return actionSheetController
        
    }

}
