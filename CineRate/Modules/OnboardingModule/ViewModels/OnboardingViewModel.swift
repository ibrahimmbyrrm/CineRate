//
//  OnboardingViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 10.06.2023.
//

import Foundation
import UIKit

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
    
    var image : UIImage {
        return UIImage(named: onboarding.image)!
    }
}
