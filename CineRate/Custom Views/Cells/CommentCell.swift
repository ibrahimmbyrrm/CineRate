//
//  CommentCell.swift
//  CineRate
//
//  Created by İbrahim Bayram on 9.06.2023.
//

import Foundation
import UIKit

import UIKit

class CommentTableViewCell: UITableViewCell {
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    }()
    private let commentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func configure(commentVM : CommentViewModel) {
        self.commentLabel.text = commentVM.commentContent
        self.usernameLabel.text = commentVM.owner
        self.dateLabel.text = commentVM.date
    }

    private func setupViews() {
        // Kullanıcı adı label'ı
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        contentView.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])

        // Yorum label'ı
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commentLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // Tarih label'ı
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

