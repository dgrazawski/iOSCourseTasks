//
//  ViewController.swift
//  combine_9
//
//  Created by Dawid Grazawski on 05/08/2025.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel = PostListVM()
    private var subscription: AnyCancellable? = nil
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "postTitle")
        bindViewModel()
        viewModel.fetchPosts()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        subscription = viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] posts in
                self?.tableView.reloadData()
            }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTitle", for: indexPath)
        let post = viewModel.posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
}
