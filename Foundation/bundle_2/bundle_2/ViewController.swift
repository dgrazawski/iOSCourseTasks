//
//  ViewController.swift
//  bundle_2
//
//  Created by Dawid Grazawski on 29/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    let cacheManager = CustomCacheManager(networkManager: NetworkManager())
    
    private var photos: [PhotoModel] = []
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "Cached pics"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clearButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        config.baseBackgroundColor = .red
        button.configuration = config
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(clearButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.rowHeight = view.frame.width - 20
        
        clearButton.addTarget(self, action: #selector(clearButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: clearButton.widthAnchor),
            
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            clearButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
            
        ])
        loadPhotos()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoryWarningInController),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }

    
    @objc func clearButtonTap() {
        cacheManager.clearCache()
            photos.removeAll()
        tableView.reloadData()
    }
    
    @objc private func handleMemoryWarningInController(){
            photos.removeAll()
        tableView.reloadData()
    }
    
    func loadPhotos() {
        Task {
            do {
                self.photos = try await cacheManager.networkManager.fetchPhotos()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error loading photo metadata: \(error)")
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let photo = photos[indexPath.row]
        cell.configure(with: photo, cacheManager: cacheManager)
        return cell
    }
    
    
}
