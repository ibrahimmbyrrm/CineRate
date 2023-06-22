//
//  OnbıardingContracts.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation

protocol OnboardingViewInterface {
    func setupConstraints()
    func addSubviews()
    func prepareCollectionView()
    func preparePageControl()
}

protocol OnboardingViewModelInterface {
    var onboardingViewDelegate : OnboardingViewInterface? {get set}
    var onboardingPages : [OnboardingPage] {get set}
    var lastIndex : Int {get}
    
    func numberOfItemsInSection(_ section : Int) -> Int
    func itemAtIndex(_ index : Int) -> OnboardingViewModel
    func viewDidLoad()
}
