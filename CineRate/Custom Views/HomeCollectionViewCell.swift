//
//  HomeCollectionViewCell.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(movieImageView)

        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
            
        self.addSubview(movieNameLabel)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 4).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        movieNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(viewModel : MovieViewModel) {
        self.movieNameLabel.text = viewModel.title.uppercased()
        self.movieImageView.sd_setImage(with: viewModel.posterImage)
    }

}
