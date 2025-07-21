//
//  ReceiverVC.swift
//  notifications_task_1
//
//  Created by Dawid Grazawski on 21/07/2025.
//

import UIKit

class ReceiverVC: UIViewController {
        
    private let receiverLabel = {
        let label = UILabel()
        label.text = "Received 0 times"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinitialazing receiver vc")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(receiverLabel)
        NSLayoutConstraint.activate([
            receiverLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            receiverLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            receiverLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            receiverLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func handleNotification(notification: Notification) {
        print("Notification received!")
        guard let receivedCounter = notification.userInfo?["counter"] as? Int else { return }
        DispatchQueue.main.async { [weak self] in
            self?.receiverLabel.text = "Received \(receivedCounter) times"
        }
        
    }
}
