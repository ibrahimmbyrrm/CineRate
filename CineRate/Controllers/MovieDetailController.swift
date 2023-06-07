//
//  MovieDetailController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 6.06.2023.
//

import Foundation
import UIKit

class MovieDetailController : UIViewController {
    
    private let movie : Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(movie : Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
