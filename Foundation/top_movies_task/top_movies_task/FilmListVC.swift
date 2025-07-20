//
//  FilmListVC.swift
//  top_movies_task
//
//  Created by Dawid Grazawski on 10/07/2025.
//

import UIKit

class FilmListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    let network = NetworkManager()
    
    private var movies: [Movie] = []
    
    private var filmCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section,Movie>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        fetchData()
        view.backgroundColor = .systemBackground
    }
    
    deinit {
        network.invalidateAndCancel()
    }
    
    func fetchData() {
        let link = network.buildTopRatedURL(language: "en-US", page: 1)
        network.getTopRated(url: link) { [weak self] result in
            switch result {
            case .success(let list):
                self?.movies = list.results
                self?.updateData()
                dump(list)
            case .failure(let error):
                print(error.rawValue)
                self?.showAlert(message: error.rawValue)
            }
        }
    }
    
    func setupCollectionView() {
        filmCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCollectionViewFlowLayout())
        view.addSubview(filmCollectionView)
       // filmCollectionView.backgroundColor = .systemCyan
        filmCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    func setupCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 0
        let availableWidth = width - (padding * 2)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: availableWidth, height: availableWidth)
        return flowLayout
    }

    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>(collectionView: filmCollectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
            cell.delegate = self
            cell.setupCell(movie: movie)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

}

extension FilmListVC {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
