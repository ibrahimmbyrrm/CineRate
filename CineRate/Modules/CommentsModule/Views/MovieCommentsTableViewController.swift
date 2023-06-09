//
//  MovieCommentsTableViewController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 9.06.2023.
//

import UIKit

protocol CommentListViewProtocol {
    func refreshData()
}

class MovieCommentsTableViewController: UITableViewController {
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "No one has commented on this movie yet."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        return label
    }()

    var commentListVM : CommentListViewModelProtocol!
    var selectedVM : MovieDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        commentListVM.fetchData()
        commentListVM.delegate = self
    }
    
    private func setupViews() {
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        tableView.estimatedRowHeight = 100
        tableView.backgroundView = messageLabel
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addCommentTapped))
    }
    

    @objc func addCommentTapped() {
        let alertController = UIAlertController(title: "Add your comment", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        alertController.textFields?.first?.placeholder = "What do you think about this movie?"
        let saveButton = UIAlertAction(title: "Save", style: .default) { action in
            guard let comment = alertController.textFields?.first?.text else {return}
            FirebaseFirestoreService.shared.saveComment(movieId: self.selectedVM.id, comment: comment)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(saveButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true)

    }
    
}
extension MovieCommentsTableViewController : CommentListViewProtocol {
    
    func refreshData() {
        self.tableView.reloadAsync()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = commentListVM.numberOfRowsInSection(section)
        tableView.backgroundView?.isHidden = rowCount != 0
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        let commentVM = commentListVM.itemAtIndex(indexPath.row)
        cell.configure(commentVM: commentVM)
        return cell
    }
}
