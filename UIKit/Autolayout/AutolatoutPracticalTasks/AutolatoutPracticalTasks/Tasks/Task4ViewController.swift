//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    
    let firstV = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondV = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerForTraitChanges()
    }
    
    private func setup(){
        view.addSubview(firstV)
        view.addSubview(secondV)
        verticalConstraints = verticalLayout()
        horizontalConstraints = horizontalLayout()
        updateConstraintsForRotation()
    }
    
    private func verticalLayout() -> [NSLayoutConstraint] {
        return [
            //First green
            firstV.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            firstV.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            firstV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstV.bottomAnchor.constraint(equalTo: secondV.topAnchor, constant: -10),
            //Second red
            secondV.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            secondV.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            secondV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            secondV.topAnchor.constraint(equalTo: firstV.bottomAnchor, constant: 10),
            secondV.heightAnchor.constraint(equalTo: firstV.heightAnchor)
        ]
    }
    
    private func horizontalLayout() -> [NSLayoutConstraint] {
        return [
            //First green
            firstV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            firstV.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            firstV.trailingAnchor.constraint(equalTo: secondV.leadingAnchor, constant: -10),
            //Second red
            secondV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            secondV.leadingAnchor.constraint(equalTo: firstV.trailingAnchor, constant: 10),
            secondV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            secondV.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            secondV.widthAnchor.constraint(equalTo: firstV.widthAnchor)
        ]
    }
    
    private func updateConstraintsForRotation() {
        NSLayoutConstraint.deactivate(verticalConstraints + horizontalConstraints)
        
        let isVertical = traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular
        
        if isVertical {
            NSLayoutConstraint.activate(verticalConstraints)
        } else {
            NSLayoutConstraint.activate(horizontalConstraints)
        }
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            // TODO: -  Handle the trait change.
            self.updateConstraintsForRotation()
            print("Trait collection changed:", self.traitCollection)
        }
    }
}

#Preview {
    Task4ViewController()
}
