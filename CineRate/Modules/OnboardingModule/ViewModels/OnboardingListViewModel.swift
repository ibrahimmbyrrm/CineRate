//
//  OnboardingViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation
import UIKit

class OnboardingListViewModel {
    let onboardingPages = [
        OnboardingPage(title: "Welcome !", description: "You've come to the right place to dive into the realm of the most popular movies.",image:"onboarding1.jpg"),
        OnboardingPage(title: "World Wide Access", description: "See comments made by people from all around the world about movies. As you watch them, add a comment yourself.",image: "onboarding2.jpg"),
        OnboardingPage(title: "Sit Back and Enjoy the Show", description: "After finding the right movie with CineRate, all you need to do is relax and immerse yourself in the flow of the film.",image: "onboarding3.jpg"),
    ]
}

extension OnboardingListViewModel {
    
    var lastIndex : Int {
        return onboardingPages.count - 1
    }
    
    func numberOfItemsInSection(_ section : Int) -> Int {
        return self.onboardingPages.count
    }
    
    func itemAtIndex(_ index : Int) -> OnboardingViewModel {
        return OnboardingViewModel(onboarding: onboardingPages[index])
    }
}


