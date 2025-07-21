//
//  ViewController.swift
//  notifications_task_3
//
//  Created by Dawid Grazawski on 21/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    let label = {
       let label = UILabel()
        label.textColor = .black
        label.text = "Background log task"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNotifications()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func prepareNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appDidEnterBackground(notification: Notification) {
        let now = Date()
        print("\(now) - App entered background")
    }

    @objc func appDidEnterForeground(notification: Notification) {
        let now =  Date()
       print("\(now) - App entered foreground")
    }
}

