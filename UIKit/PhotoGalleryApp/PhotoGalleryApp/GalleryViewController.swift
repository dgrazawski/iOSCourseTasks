//
//  GalleryViewController.swift
//  PhotoGalleryApp
//
//  Created by Dawid Grazawski on 29/06/2025.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var galleryData = GalleryDataSource.mockupData
    private var groupedData: [String: [GalleryDataSource]] = [:]
    private var sectionDates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupCollectionView()
        groupDataByDate()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
        
    private func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        collectionView.register(GallerySectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GallerySectionHeaderView.identifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func groupDataByDate() {

        groupedData = Dictionary(grouping: galleryData) { $0.date }
        
        sectionDates = groupedData.keys.sorted { date1, date2 in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            guard let d1 = formatter.date(from: date1),
                  let d2 = formatter.date(from: date2) else {
                return date1 < date2
            }
            return d1 < d2
        }
    }
    
    private func numberOfColumns() -> Int {
        
        let orientation = UIDevice.current.orientation
        return orientation.isLandscape ? 5 : 3
    }
    
    private func showFavoriteAlert(for item: GalleryDataSource) {
        
        let message = item.isFavourite ?
            "Marked \(item.title) as Favorite!" :
            "Removed \(item.title) from Favorites."
        
        let alert = UIAlertController(title: "Favorite Updated", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let date = sectionDates[section]
        return groupedData[date]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        
        let date = sectionDates[indexPath.section]
        
        if let items = groupedData[date], indexPath.row < items.count {
            
            let item = items[indexPath.row]
            cell.configure(with: item)
            cell.onFavoriteButtonTapped = { [weak self] in
                self?.handleFavoriteToggle(at: indexPath)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GallerySectionHeaderView.identifier, for: indexPath) as! GallerySectionHeaderView
            
            let date = sectionDates[indexPath.section]
            header.configure(with: date)
            
            return header
        }
        return UICollectionReusableView()
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns = CGFloat(numberOfColumns())
        let spacing: CGFloat = 8
        let sectionInset: CGFloat = 16
        
        let totalSpacing = (columns - 1) * spacing + (sectionInset * 2)
        let availableWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = availableWidth / columns
        let itemHeight = itemWidth * 0.8 + 40
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

private extension GalleryViewController {
    
    func handleFavoriteToggle(at indexPath: IndexPath) {
        
        let date = sectionDates[indexPath.section]
        guard var items = groupedData[date], indexPath.row < items.count else { return }

        items[indexPath.row].isFavourite.toggle()
        groupedData[date] = items
        
        if let mainIndex = galleryData.firstIndex(where: { $0.title == items[indexPath.row].title }) {
            galleryData[mainIndex].isFavourite = items[indexPath.row].isFavourite
        }
        
        collectionView.reloadItems(at: [indexPath])
        showFavoriteAlert(for: items[indexPath.row])
    }
}
