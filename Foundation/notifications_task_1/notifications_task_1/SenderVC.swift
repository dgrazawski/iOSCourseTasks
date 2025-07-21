//
//  SenderVC.swift
//  notifications_task_1
//
//  Created by Dawid Grazawski on 21/07/2025.
//

import UIKit

class SenderVC: UIViewController {
    
    private let senderButton = {
        let button = UIButton(type: .system)
        let config = UIButton.Configuration.filled()
        button.configuration = config
        button.setTitle("Send", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(senderButton)
        senderButton.addTarget(self, action: #selector(sendNotification), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            senderButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            senderButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            senderButton.widthAnchor.constraint(equalToConstant: 100),
            senderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func sendNotification() {
        NotificationCenter.default.post(name: Notification.Name("SendToReceiver"), object: nil)
        print("sended")
    }


}

