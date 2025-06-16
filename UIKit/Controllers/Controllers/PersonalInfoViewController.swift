//
//  PersonalInfoViewController.swift
//  Controllers
//
//  Created by Dawid Grazawski on 17/06/2025.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    let alertController = UIAlertController(title: "Confirm Information", message: "Please confirm your name and phone number. Name: [User's Name], Phone: [User's Phone].", preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "Confirm", style: .default) {_ in 
        
    }
    
    let editAction = UIAlertAction(title: "Edit", style: .cancel) { _ in
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        alertController.addAction(confirmAction)
        alertController.addAction(editAction)
        present(alertController, animated: true, completion: nil)
    }
}
