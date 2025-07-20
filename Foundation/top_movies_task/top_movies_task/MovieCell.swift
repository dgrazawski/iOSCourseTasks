//
//  MovieCell.swift
//  top_movies_task
//
//  Created by Dawid Grazawski on 14/07/2025.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    weak var delegate: FilmListVC?
    
    private let nameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstAirDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let voteAverageLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let originCountryLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let popularityLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
       // label.backgroundColor = .red
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let posterImageViev = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageViev.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImageViev.widthAnchor.constraint(equalToConstant: 100),
            posterImageViev.heightAnchor.constraint(equalToConstant: 148),
            posterImageViev.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            overviewLabel.topAnchor.constraint(equalTo: posterImageViev.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            overviewLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15),
            
            nameLabel.topAnchor.constraint(equalTo: posterImageViev.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageViev.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            firstAirDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            firstAirDateLabel.leadingAnchor.constraint(equalTo: posterImageViev.trailingAnchor, constant: 15),
            firstAirDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            voteAverageLabel.topAnchor.constraint(equalTo: firstAirDateLabel.bottomAnchor, constant: 10),
            voteAverageLabel.leadingAnchor.constraint(equalTo: posterImageViev.trailingAnchor, constant: 15),
            voteAverageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            originCountryLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 10),
            originCountryLabel.leadingAnchor.constraint(equalTo: posterImageViev.trailingAnchor, constant: 15),
            originCountryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            popularityLabel.topAnchor.constraint(equalTo: originCountryLabel.bottomAnchor, constant: 10),
            popularityLabel.leadingAnchor.constraint(equalTo: posterImageViev.trailingAnchor, constant: 15),
            popularityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    func setupUI() {
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(nameLabel)
        contentView.addSubview(firstAirDateLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(originCountryLabel)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(posterImageViev)
        setupConstraints()
    }
    
    func setupCell(movie: Movie) {
        nameLabel.text = movie.name
        firstAirDateLabel.text = "First air date - \(movie.firstAirDate)"
        voteAverageLabel.text = "Rating - \(String(format: "%.1f", movie.voteAverage))"
        overviewLabel.text = movie.overview
        originCountryLabel.text = "Countries - " + movie.originCountry.joined(separator: ", ")
        popularityLabel.text = "Popularity - " + String(format: "%.0f", movie.popularity)

        let path = delegate?.network.buildPicURL(bdPath: movie.posterPath)
        delegate?.network.getPoster(url: path) { [weak self] result in
            switch result {
                
            case .success(let img):
                DispatchQueue.main.async {
                    self?.posterImageViev.image = img
                }
            case .failure(let error):
                print(error.rawValue)
                self?.delegate?.showAlert(message: error.rawValue)
            }
        }
    }
    
}
