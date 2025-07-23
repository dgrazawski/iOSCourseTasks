//
//  SearchVC.swift
//  notifications_task_2_3
//
//  Created by Dawid Grazawski on 23/07/2025.
//

import UIKit

class SearchVC: UIViewController {
    
    private var searchResults: [String] = []
    
    private let searchTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Search..."
        textfield.borderStyle = .roundedRect
        textfield.font = .systemFont(ofSize: 20)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let searchButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        
        prepareTableView()
        prepareData()
        searchButton.addTarget(self, action: #selector(tapSearch), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResult")
    }
    
    func prepareData() {
        guard let searchFromDefaults = UserDefaults.standard.stringArray(forKey: "search") else { return }
        searchResults = searchFromDefaults
        tableView.reloadData()
    }
    
    @objc func tapSearch() {
        guard let textFromField = searchTextField.text else { return }
        if textFromField.isEmpty {
            return
        }
        
        var array = UserDefaults.standard.stringArray(forKey: "search") ?? []
        if array.count >= 5 {
            array.removeLast()
        }
        array.insert(textFromField, at: 0)
        UserDefaults.standard.set(array, forKey: "search")
        UserDefaults.standard.synchronize()
        prepareData()
    }
    
    
}


extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    
}
