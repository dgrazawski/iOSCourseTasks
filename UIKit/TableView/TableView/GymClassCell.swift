//
//  GymClassCell.swift
//  TableView
//
//  Created by Dawid Grazawski on 26/06/2025.
//

import UIKit

class GymClassCell: UITableViewCell {
    
    private lazy var registerButton: UIButton = {
        var config = UIButton.Configuration.filled()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let plusImage = UIImage(systemName: "plus.circle", withConfiguration: imageConfig)
        config.image = plusImage
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let button = UIButton(configuration: config)
        button.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            let symbolName = self.isRegistered ? "x.circle" : "plus.circle"
            config?.image = UIImage(systemName: symbolName)
            button.configuration = config
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        contentView.addSubview(registerButton)
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
    
    @objc func buttonTapped(){
                guard let gymClass = gymClass else { return }
                guard let delegate = delegate else { return }
        //        gymClass.isRegistered = !gymClass.isRegistered
        //        isRegistered = gymClass.isRegistered
        //        print("gym class: \(gymClass.isRegistered), isregistered: \(isRegistered)")
        //        delegate.presentAlert(gymClass.className, isRegistered)
        isRegistered.toggle()
        delegate.didToggleRegistration(for: self)
        delegate.presentAlert(gymClass.className, isRegistered)
    }
    
    func setGym(gymClass: GymClassModel) {
        trainerImageView.image = gymClass.trainerPhoto
        timeLabel.text = gymClass.time
        durationLabel.text = "\(gymClass.duration) m"
        classNameLabel.text = gymClass.className
        trainerNameLabel.text = gymClass.trainerName
        registerButton.configuration?.image = buttonStatus(gymClass.isRegistered)
    }
    
    public var gymClass: GymClassModel? {
        didSet {
            guard let gymClass = gymClass else { return }
            trainerImageView.image = gymClass.trainerPhoto
            timeLabel.text = gymClass.time
            durationLabel.text = "\(gymClass.duration) m"
            classNameLabel.text = gymClass.className
            trainerNameLabel.text = gymClass.trainerName
            isRegistered = gymClass.isRegistered
            registerButton.configuration?.image = buttonStatus(gymClass.isRegistered)
        }
    }
    
    weak var delegate: GymClassCellDelegate? {
        didSet {
           // print("delegate ustawiony")
        }
    }
    
    public var isRegistered = false {
        didSet{
          //  print("is registered change")
            registerButton.updateConfiguration()
        }
    }
    
    private func buttonStatus(_ status: Bool) -> UIImage {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let buttonImage = UIImage(systemName: status ? "x.circle" : "plus.circle", withConfiguration: imageConfig)
        return buttonImage ?? UIImage()
    }
    
    private func setConstraints() {
            let padding: CGFloat = 20
            let spacing: CGFloat = 8
            
            NSLayoutConstraint.activate([

                registerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                registerButton.widthAnchor.constraint(equalToConstant: 50),
                registerButton.heightAnchor.constraint(equalToConstant: 50),
                
                timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                timeLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -spacing / 2),
                
                durationLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
                durationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),
                
                classNameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: padding * 1.5),
                classNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: registerButton.leadingAnchor, constant: -padding),
                classNameLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),
                
                trainerImageView.leadingAnchor.constraint(equalTo: classNameLabel.leadingAnchor),
                trainerImageView.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor, constant: spacing),
                trainerImageView.widthAnchor.constraint(equalToConstant: 30),
                trainerImageView.heightAnchor.constraint(equalToConstant: 30),
                
                trainerNameLabel.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: spacing),
                trainerNameLabel.centerYAnchor.constraint(equalTo: trainerImageView.centerYAnchor),
                trainerNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: registerButton.leadingAnchor, constant: -padding)
            ])
        }
    
}
