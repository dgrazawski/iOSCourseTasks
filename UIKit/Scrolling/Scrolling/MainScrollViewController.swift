//
//  MainScrollViewController.swift
//  Scrolling
//
//  Created by Dawid Grazawski on 21/06/2025.
//

import UIKit

class MainScrollViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemRed.withAlphaComponent(0.2)
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let imageView = {
        let imageView = UIImageView(image: UIImage(named: "scrollpic"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.delegate = self

        setupScrollViewConstraints()
        setupImageViewConstraints()
    }

    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageView()
    }
    
    private func centerImageView() {
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        

        let horizontalInset = (scrollViewSize.width - imageViewSize.width) / 2
        let verticalInset = (scrollViewSize.height - imageViewSize.height) / 2
        
        let topInset = max(0, verticalInset)
        let leftInset = max(0, horizontalInset)
        let bottomInset = max(0, verticalInset)
        let rightInset = max(0, horizontalInset)
        
        scrollView.contentInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        
        if imageViewSize.width > scrollViewSize.width || imageViewSize.height > scrollViewSize.height {
            let centerX = (imageViewSize.width - scrollViewSize.width) / 2
            let centerY = (imageViewSize.height - scrollViewSize.height) / 2
            
            scrollView.contentOffset = CGPoint(x: max(0, centerX), y: max(0, centerY))
        }
    }
}
