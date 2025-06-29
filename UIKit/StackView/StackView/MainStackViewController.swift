//
//  MainStackViewController.swift
//  StackView
//
//  Created by Dawid Grazawski on 29/06/2025.
//

import UIKit

class MainStackViewController: UIViewController {
    
    private var isTaggedPostsVisible = false
    
    private let mainStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.alignment = .fill
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonStack = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.alignment = .fill
        //   stackView.backgroundColor = .red
        //  stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let taggedPostsSection: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = DataSource.taggedPosts
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mainStackView)
        view.addSubview(buttonStack)
        setupHeaderStack()
        setupBioSection()
        setupStatisticsSection()
        setupControlButtons()
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func setupHeaderStack() {
        let headerStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 15
            stack.alignment = .center
            stack.distribution = .fill
            //  stack.backgroundColor = .cyan
            return stack
        }()
        
        let profilePic = {
            let pic = UIImageView()
            pic.backgroundColor = .systemGray4
            pic.layer.cornerRadius = 40
            pic.clipsToBounds = true
            pic.image = DataSource.image
            pic.translatesAutoresizingMaskIntoConstraints = false
            return pic
        }()
        
        let nameLabel = {
            let label = UILabel()
            label.text = DataSource.name
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = .label
            return label
        }()
        
        let followButton = {
            let button = UIButton(type: .system)
            button.setTitle("Follow", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        headerStack.addArrangedSubview(profilePic)
        headerStack.addArrangedSubview(nameLabel)
        headerStack.addArrangedSubview(followButton)
        
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 80),
            profilePic.heightAnchor.constraint(equalToConstant: 80),
            followButton.widthAnchor.constraint(equalToConstant: 80),
            followButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        mainStackView.addArrangedSubview(headerStack)
    }
    
    private func setupBioSection() {
        let bioLabel = {
            let label = UILabel()
            label.text = DataSource.bioText
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            label.numberOfLines = 0
            //  label.backgroundColor = .red
            return label
        }()
        mainStackView.addArrangedSubview(bioLabel)
    }
    
    private func setupStatisticsSection() {
        let statsStackView = UIStackView()
        statsStackView.axis = .horizontal
        statsStackView.spacing = 20
        statsStackView.alignment = .leading
        statsStackView.distribution = .fillProportionally
        
        let followersStack = createStatView(title: "Followers", count: DataSource.followers)
        let followingStack = createStatView(title: "Following", count: DataSource.following)
        let postsStack = createStatView(title: "Posts", count: DataSource.posts)
        //   let taggedPosts = createStatView(title: "Tagged posts", count: "1.2KK")
        
        statsStackView.addArrangedSubview(followersStack)
        statsStackView.addArrangedSubview(followingStack)
        statsStackView.addArrangedSubview(postsStack)
        //   statsStackView.addArrangedSubview(taggedPosts)
        
        mainStackView.addArrangedSubview(statsStackView)
    }
    
    private func createStatView(title: String, count: String) -> UIStackView {
        let statStack = UIStackView()
        statStack.axis = .horizontal
        statStack.spacing = 2
        statStack.alignment = .center
        statStack.distribution = .fill
        
        let countLabel = UILabel()
        countLabel.text = count
        countLabel.font = .boldSystemFont(ofSize: 14)
        countLabel.textColor = .label
        countLabel.adjustsFontSizeToFitWidth = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        
        statStack.addArrangedSubview(titleLabel)
        statStack.addArrangedSubview(countLabel)
        
        return statStack
    }
    
    private func setupControlButtons() {
        let toggleTaggedButton = UIButton(type: .system)
        toggleTaggedButton.setTitle("Tagged Posts", for: .normal)
        toggleTaggedButton.backgroundColor = .systemBlue
        toggleTaggedButton.setTitleColor(.white, for: .normal)
        toggleTaggedButton.layer.cornerRadius = 8
        toggleTaggedButton.addTarget(self, action: #selector(toggleTaggedPosts), for: .touchUpInside)
        
        let hideBioButton = UIButton(type: .system)
        hideBioButton.setTitle("Hide/Show Bio", for: .normal)
        hideBioButton.backgroundColor = .systemBlue
        hideBioButton.setTitleColor(.white, for: .normal)
        hideBioButton.layer.cornerRadius = 8
        hideBioButton.addTarget(self, action: #selector(toggleBioVisibility), for: .touchUpInside)
        
        let hideStatsButton = UIButton(type: .system)
        hideStatsButton.setTitle("Hide/Show Stats", for: .normal)
        hideStatsButton.backgroundColor = .systemBlue
        hideStatsButton.setTitleColor(.white, for: .normal)
        hideStatsButton.layer.cornerRadius = 8
        hideStatsButton.addTarget(self, action: #selector(toggleStatsVisibility), for: .touchUpInside)
        
        buttonStack.addArrangedSubview(toggleTaggedButton)
        buttonStack.addArrangedSubview(hideBioButton)
        buttonStack.addArrangedSubview(hideStatsButton)
        
        mainStackView.addArrangedSubview(buttonStack)
    }
    
    @objc private func toggleTaggedPosts() {
        
        if isTaggedPostsVisible {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.taggedPostsSection.alpha = 0
                self.mainStackView.layoutIfNeeded()
                
            }) { _ in
                
                self.mainStackView.removeArrangedSubview(self.taggedPostsSection)
                self.taggedPostsSection.removeFromSuperview()
                self.isTaggedPostsVisible = false
            }
        } else {
            
            taggedPostsSection.alpha = 0
            mainStackView.insertArrangedSubview(taggedPostsSection, at: 3)
            
            UIView.animate(withDuration: 0.3) {
                self.taggedPostsSection.alpha = 1
                self.mainStackView.layoutIfNeeded()
                self.isTaggedPostsVisible = true
            }
            
        }
    }
    
    @objc private func toggleBioVisibility() {
        let bioSection = mainStackView.arrangedSubviews[1]
        UIView.animate(withDuration: 0.3) {
            bioSection.isHidden.toggle()
            self.mainStackView.layoutIfNeeded()
        }
    }
    
    @objc private func toggleStatsVisibility() {
        let statsSection = mainStackView.arrangedSubviews[2]
        UIView.animate(withDuration: 0.3) {
            statsSection.isHidden.toggle()
            self.mainStackView.layoutIfNeeded()
        }
    }
    
    
}

