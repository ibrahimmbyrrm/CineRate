//
//  HomeCollectionViewCell.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let filmAdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Hücre arkaplanı ve kenarlık
        self.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        // Hücre altında filmImageView ekle
        self.addSubview(filmImageView)

        filmImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        filmImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        filmImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        filmImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        
        // Hücre altında filmAdLabel ekle
        self.addSubview(filmAdLabel)
        filmAdLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 4).isActive = true
        filmAdLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        filmAdLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        filmAdLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with film: Film) {
        filmAdLabel.text = film.ad.capitalized
        filmImageView.image = film.foto
    }
}
