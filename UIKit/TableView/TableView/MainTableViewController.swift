//
//  MainTableViewController.swift
//  TableView
//
//  Created by Dawid Grazawski on 26/06/2025.
//

import UIKit

class MainTableViewController: UIViewController {
    
    private var classesData: [GymClassModel] = []
    private var groupedClasses: [(day: String, classes: [GymClassModel])] = []
    
    private let dateFormatterForSorting: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        classesData = GymClassModel.mockupData
        makeGroupedData()
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
    
    private func makeGroupedData() {
        let groupedDict = Dictionary(grouping: classesData) { $0.day }
        groupedClasses = groupedDict
            .sorted {
                guard let date1 = dateFormatterForSorting.date(from: $0.key),
                      let date2 = dateFormatterForSorting.date(from: $1.key) else {
                    return $0.key < $1.key
                }
                return date1 < date2
            }
            .map { (day: $0.key, classes: $0.value) }
    }


}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedClasses.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedClasses[section].classes.count
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return groupedClasses[section].day
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGray6

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        label.textColor = .black
        label.text = groupedClasses[section].day  // ✅ correct access
        label.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GymCell", for: indexPath) as! GymClassCell
        let gymClass = groupedClasses[indexPath.section].classes[indexPath.row]
        cell.gymClass = gymClass
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupedClasses[indexPath.section].classes.remove(at: indexPath.row)
            if groupedClasses[indexPath.section].classes.isEmpty {
                groupedClasses.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
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

        }

        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func didToggleRegistration(for cell: GymClassCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        groupedClasses[indexPath.section].classes[indexPath.row].isRegistered.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
