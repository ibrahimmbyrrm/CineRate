//
//  MovieCommentsTableViewController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 9.06.2023.
//

import UIKit

class MovieCommentsTableViewController: UITableViewController {
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "No one has commented on this movie yet."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()
    
    var comments = [Comment]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var movie : Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        FirebaseFirestoreService().fetchCommentsa(movieID: self.movie.id) { comments in
            self.comments = comments!
        }
        
    }
    
    private func setupViews() {
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundView = messageLabel
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addCommentTapped))
    }
    

    @objc func addCommentTapped() {
        FirebaseFirestoreService().saveComment(movie: movie, comment: "klmasfkmlfdskldsfklndknl")
        
    }
    
}
extension MovieCommentsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = comments.count
        tableView.backgroundView?.isHidden = rowCount != 0
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        let comment = comments[indexPath.row]
        cell.configure(comment: comment)
        
        return cell
    }
}
