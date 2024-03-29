//
//  ViewController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 30.05.2023.
//

import UIKit
import Firebase
import SnapKit

class OnboardingController: UIViewController, OnboardingViewInterface {
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
        button.addTarget(nil, action: #selector(nextButtonTapped), for: .touchUpInside)
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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: Constants.Identifiers.onboardingCell)
        return collectionView
    }()
    
    private var onboardingListViewModel : OnboardingViewModelInterface = OnboardingListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingListViewModel.onboardingViewDelegate = self
        onboardingListViewModel.viewDidLoad()
    }
    
    // MARK: -Setup All UI Objects and Properties
    func addSubviews() {
        [collectionView,nextButton,pageControl].forEach { v in
            view.addSubview(v)
        }
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func preparePageControl() {
        pageControl.numberOfPages = onboardingListViewModel.onboardingPages.count
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    }
    
    @objc private func nextButtonTapped() {
        if currentPageIndex == onboardingListViewModel.lastIndex {
            performSegue(withIdentifier: Constants.Identifiers.onboardingToLoginSegue, sender: nil)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.onboardingCell, for: indexPath) as! OnboardingCell
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


