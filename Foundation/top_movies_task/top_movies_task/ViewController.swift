//
//  ViewController.swift
//  top_movies_task
//
//  Created by Dawid Grazawski on 10/07/2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let network = NetworkManager()
        let link = network.buildTopRatedURL(language: "en-US", page: 1)
        network.getTopRated(url: link) { result in
            switch result {
            case .success(let list):
                print(list)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }


}

