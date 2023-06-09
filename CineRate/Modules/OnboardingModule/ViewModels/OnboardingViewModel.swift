//
//  OnboardingViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 10.06.2023.
//

import Foundation

class OnboardingViewModel {
    let onboarding :OnboardingPage
    
    init(onboarding: OnboardingPage) {
        self.onboarding = onboarding
    }
}

extension OnboardingViewModel {
    
    var title : String {
        return onboarding.title
    }
    
    var description : String {
        return onboarding.description
    }
}
