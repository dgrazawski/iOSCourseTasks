//
//  ViewController.swift
//  notifications_task_2_1
//
//  Created by Dawid Grazawski on 22/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = {
        let label = UILabel()
        label.text = "Dark mode switch: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch = {
        let toggle = UISwitch()
        toggle.isOn = UserDefaults.standard.bool(forKey: "isDark")
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setDarkMode()
        view.addSubview(label)
        view.addSubview(toggleSwitch)
        toggleSwitch.addTarget(self, action: #selector(changedDark), for: UIControl.Event.valueChanged)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            toggleSwitch.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
            toggleSwitch.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            toggleSwitch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func changedDark(sender: UISwitch){
        print(sender.isOn)
        UserDefaults.standard.set(sender.isOn, forKey: "isDark")
        setDarkMode()
    }
    
    func setDarkMode() {
        overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "isDark") ? .dark : .light
    }
    
}

