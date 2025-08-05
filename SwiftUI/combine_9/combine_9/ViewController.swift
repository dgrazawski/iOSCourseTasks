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
    private var cancellables = Set<AnyCancellable>()
    private var posts: [PostModel] = []
    
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
        viewModel.$posts
            .sink { [weak self] posts in
                self?.posts = posts
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTitle", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
}
