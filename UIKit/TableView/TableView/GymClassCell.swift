//
//  GymClassCell.swift
//  TableView
//
//  Created by Dawid Grazawski on 26/06/2025.
//

import UIKit

class GymClassCell: UITableViewCell {
    
    private let registerButton = {
        var config = UIButton.Configuration.filled()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let plusImage = UIImage(systemName: "plus.circle", withConfiguration: imageConfig)
        config.image = plusImage
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let durationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let classNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trainerNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trainerImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(registerButton)
        addSubview(timeLabel)
        addSubview(durationLabel)
        addSubview(classNameLabel)
        addSubview(trainerNameLabel)
        addSubview(trainerImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGym(gymClass: GymClassModel) {
        trainerImageView.image = gymClass.trainerPhoto
        timeLabel.text = gymClass.time
        durationLabel.text = "\(gymClass.duration) m"
        classNameLabel.text = gymClass.className
        trainerNameLabel.text = gymClass.trainerName
    }
    
    private func setConstraints() {
            let padding: CGFloat = 20 // Standard padding from edges
            let spacing: CGFloat = 8 // Standard spacing between elements
            
            NSLayoutConstraint.activate([
                // MARK: - Register Button Constraints
                // Vertically center the button
                registerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                // Align to the trailing edge with some padding
                registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                // Set a fixed width and height for the button to ensure it's circular
                // The size of the SF Symbol itself dictates the visual size, but the button frame needs bounds.
                // A size around 60x60 points seems appropriate for the 50pt symbol.
                registerButton.widthAnchor.constraint(equalToConstant: 50),
                registerButton.heightAnchor.constraint(equalToConstant: 50),
                
                // MARK: - Time and Duration Labels Constraints
                // timeLabel leading edge aligned with cell's leading edge
                timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                // Position timeLabel slightly above the vertical center
                timeLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -spacing / 2),
                
                // durationLabel leading edge aligned with timeLabel's leading edge
                durationLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
                // durationLabel top edge below timeLabel with standard spacing
                durationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2), // Slightly less spacing visually
                
                // MARK: - Class Name and Trainer Info Constraints
                // classNameLabel leading edge with a good space from timeLabel's trailing edge
                classNameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: padding * 1.5),
                // classNameLabel trailing edge should not overlap with the registerButton
                classNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: registerButton.leadingAnchor, constant: -padding),
                // classNameLabel top aligned with timeLabel's top for a clean look
                classNameLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),
                
                // trainerImageView leading edge aligned with classNameLabel's leading edge
                trainerImageView.leadingAnchor.constraint(equalTo: classNameLabel.leadingAnchor),
                // trainerImageView top edge below classNameLabel with spacing
                trainerImageView.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor, constant: spacing),
                // Fixed size for the trainer image
                trainerImageView.widthAnchor.constraint(equalToConstant: 30),
                trainerImageView.heightAnchor.constraint(equalToConstant: 30),
                
                // trainerNameLabel leading edge to the right of trainerImageView
                trainerNameLabel.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: spacing),
                // trainerNameLabel vertically centered with trainerImageView
                trainerNameLabel.centerYAnchor.constraint(equalTo: trainerImageView.centerYAnchor),
                // trainerNameLabel trailing edge should not overlap with the registerButton
                trainerNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: registerButton.leadingAnchor, constant: -padding)
            ])
        }
    
}
