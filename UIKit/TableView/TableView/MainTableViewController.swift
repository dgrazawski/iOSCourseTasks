//
//  MainTableViewController.swift
//  TableView
//
//  Created by Dawid Grazawski on 26/06/2025.
//

import UIKit

class MainTableViewController: UIViewController {
    
    private var classesData: [GymClassModel] = []
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        classesData = GymClassModel.mockupData
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(GymClassCell.self, forCellReuseIdentifier: "GymCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }


}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GymCell") as! GymClassCell
        let gymClass = classesData[indexPath.row]
        //cell.setGym(gymClass: gymClass)
        cell.gymClass = gymClass
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            classesData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
}

protocol GymClassCellDelegate: AnyObject {
    func presentAlert(_ gymClassName: String, _ status: Bool)
    func didToggleRegistration(for cell: GymClassCell)
}

extension MainTableViewController: GymClassCellDelegate {
    func presentAlert(_ gymClassName: String, _ status: Bool) {
        let message = status ? "You have registered to \(gymClassName), see you there!" : "You have just cancelled \(gymClassName) :("
        let alertController = UIAlertController(title: "Gym Class", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK button tap
        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func didToggleRegistration(for cell: GymClassCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        // Toggle in your model
        classesData[indexPath.row].isRegistered.toggle()

        // Reload just this cell
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
