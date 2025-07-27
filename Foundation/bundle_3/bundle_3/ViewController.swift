//
//  ViewController.swift
//  bundle_3
//
//  Created by Dawid Grazawski on 27/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var configuration: ConfigurationModel?
    
    private var tableImages: [UIImage] = []
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.rowHeight = view.frame.width - 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
            
        ])
            configuration = loadConfigJson()
        if let configuration = configuration {
            loadImages(configuration: configuration)
            setupConfig(configuration: configuration)
            tableView.reloadData()
        }
    }
    
    func loadConfigJson() -> ConfigurationModel? {
        guard let path = Bundle.main.url(forResource: "configuration", withExtension: "json") else { return nil }

        do {
            let data = try Data(contentsOf: path)
            let configuration = try JSONDecoder().decode(ConfigurationModel.self, from: data)
            
            return configuration
        } catch {
            return nil
        }
        
    }
    
    func loadImages(configuration: ConfigurationModel) {
        var loadedImgs: [UIImage] = []
        for trainer in configuration.trainers {
            if let image = UIImage(named: trainer) {
                loadedImgs.append(image)
            }
        }
        tableImages = loadedImgs
    }
    
    func setupConfig(configuration: ConfigurationModel) {
        titleLabel.text = configuration.title
        titleLabel.font = .systemFont(ofSize: configuration.fontSize)
        overrideUserInterfaceStyle = configuration.darkMode ? .dark : .light
        tableImages = Array(tableImages.prefix(upTo: configuration.pictureAmmount))
        
    }
    
    


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.config(image: tableImages[indexPath.row])
        return cell
    }
    
    
}
