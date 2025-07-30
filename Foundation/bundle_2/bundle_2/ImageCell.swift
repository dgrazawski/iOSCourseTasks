//
//  ImageCell.swift
//  bundle_2
//
//  Created by Dawid Grazawski on 29/07/2025.
//


import UIKit

class ImageCell: UITableViewCell {
    
    private var currentTask: Task<Void, Never>?
    
    private let trainerImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(trainerImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            trainerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            trainerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            trainerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            trainerImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with photo: PhotoModel, cacheManager: CustomCacheManager) {
            currentTask = Task {
                do {
                    let image = try await cacheManager.getImage(for: photo)
                    await MainActor.run {
                        self.trainerImageView.image = image
                    }
                } catch {
                    print("Failed to load image for ID: \(photo.id)")
                }
            }
        }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            trainerImageView.image = nil
            currentTask?.cancel()
        }

}
