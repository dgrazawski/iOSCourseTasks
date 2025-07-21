//
//  ReceiverVC.swift
//  notifications_task_1
//
//  Created by Dawid Grazawski on 21/07/2025.
//

import UIKit

class ReceiverVC: UIViewController {
    
    private var counter = 0
    
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
        // NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: Notification.Name("SendToReceiver"), object: nil)
        receiverLabel.text = "Received \(counter) times"
        NSLayoutConstraint.activate([
            receiverLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            receiverLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            receiverLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            receiverLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func handleNotification(notification: Notification) {
        print("Notification received!")
        counter += 1
        receiverLabel.text = "Received \(counter) times"
    }
}
