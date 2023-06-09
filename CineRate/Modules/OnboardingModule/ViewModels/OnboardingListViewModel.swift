//
//  OnboardingViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation

class OnboardingListViewModel {
    let onboardingPages = [
        OnboardingPage(title: "Hoş Geldiniz", description: "Uygulamamıza hoş geldiniz! Bu onboarding ekranı size uygulamanın temel özelliklerini tanıtacak."),
        OnboardingPage(title: "Sayfa 1", description: "Onboarding ekranının ilk sayfası."),
        OnboardingPage(title: "Sayfa 2", description: "Onboarding ekranının ikinci sayfası."),
        OnboardingPage(title: "Sayfa 3", description: "Onboarding ekranının üçüncü sayfası.")
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


