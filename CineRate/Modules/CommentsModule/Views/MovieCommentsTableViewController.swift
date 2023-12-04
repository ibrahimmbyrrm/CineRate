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

    var commentListVM : CommentListViewModelProtocol!
    weak var selectedVM : MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentListVM.delegate = self
        commentListVM.fetchData()
        commentListVM.viewDidLoad()
    }
    
    func setupBackgroundColor() {
        view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
    }
    
    func prepareNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addCommentTapped))
    }
    
    func prepareTableView() {
        tableView.estimatedRowHeight = 100
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.commentCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        tableView.backgroundView = messageLabel
        tableView.tableFooterView = UIView()
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
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = commentListVM.numberOfRowsInSection(section)
        tableView.backgroundView?.isHidden = rowCount != 0
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.commentCell, for: indexPath) as! CommentTableViewCell
        let commentVM = commentListVM.itemAtIndex(indexPath.row)
        cell.configure(commentVM: commentVM)
        return cell
    }
}
