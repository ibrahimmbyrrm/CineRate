//
//  ViewController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 30.05.2023.
//

import UIKit
import Firebase

class OnboardingController: UIViewController {
    // MARK: -Programmatic UI Objects
    private let pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var currentPageIndex = 0 {
        didSet {
            pageControl.currentPage = currentPageIndex
            if currentPageIndex == onboardingListViewModel.lastIndex {
                nextButton.setTitle("Get Started", for: .normal)
            }else {
                nextButton.setTitle("Next", for: UIControl.State.normal)
            }
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        return collectionView
    }()
    
    private let onboardingListViewModel = OnboardingListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    // MARK: -Setup All UI Objects and Properties
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        // Configure Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = onboardingListViewModel.onboardingPages.count
        // Layout Settings
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    
    @objc private func nextButtonTapped() {
        if currentPageIndex == onboardingListViewModel.lastIndex {
            performSegue(withIdentifier: "toLogin", sender: nil)
        } else {
            currentPageIndex += 1
            let indexPath = IndexPath(item: currentPageIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
// MARK: - UIScrollView Embeded Functions
extension OnboardingController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = collectionView.frame.width
        let offsetX = collectionView.contentOffset.x
        let pageIndex = Int(offsetX / width)
        pageControl.currentPage = pageIndex
    }
}
// MARK: - UICollectionView Embeded Functions
extension OnboardingController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingListViewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let vm = onboardingListViewModel.itemAtIndex(indexPath.row)
        cell.titleLabel.text = vm.title
        cell.descriptionLabel.text = vm.description
        cell.imageView.image = vm.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}


