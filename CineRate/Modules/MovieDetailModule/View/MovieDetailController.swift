//
//  MovieDetailController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 6.06.2023.
//

import Foundation
import UIKit

class MovieDetailController : UIViewController , DetailViewInterface{
    var selectedMovieVM : MovieDetailViewModel
    
    init(detailVM: MovieDetailViewModel) {
        self.selectedMovieVM = detailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let moviePosterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let releaseDateLabel : MCLabel = {
        return MCLabel()
    }()
    
    private let popularityLabel : MCLabel = {
       return MCLabel()
    }()
    
    private let overviewTextView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 3.0
        textView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.orange
        textView.textAlignment = .center
        return textView
    }()
    
    private let seeCommentsButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See Comments", for: .normal)
        button.addTarget(self, action: #selector(seeCommentsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedMovieVM.detailViewDelegate = self
        selectedMovieVM.viewDidLoad()
       
    }
    func addSubviews() {
        [moviePosterImageView,releaseDateLabel,popularityLabel,overviewTextView,seeCommentsButton].forEach { v in
            view.addSubview(v)
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        populateData()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToHome))
    }
    
    func setupConstraints() {
        moviePosterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        releaseDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(20)
        }
        popularityLabel.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(20)
        }
        overviewTextView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(20)
            make.bottom.equalTo(seeCommentsButton.snp.top).offset(-20)
        }
        seeCommentsButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
    }
    
    @objc func seeCommentsButtonTapped() {
        let commentsTableViewController = MovieCommentsTableViewController()
        commentsTableViewController.commentListVM = CommentListViewModel(movieDetailVM: selectedMovieVM)
        commentsTableViewController.selectedVM = selectedMovieVM
        navigationController?.pushViewController(commentsTableViewController, animated: true)
    }
    
    private func populateData() {
        self.title = selectedMovieVM.title
        releaseDateLabel.text = selectedMovieVM.date
        popularityLabel.text = selectedMovieVM.popularity
        overviewTextView.text = selectedMovieVM.overview
       let posterURL = "\(Constants.NetworkConstants.imageBaseUrl)\(selectedMovieVM.posterPath)"
        moviePosterImageView.setImage(with: posterURL)
    }
    
    @objc func backToHome() {
        self.navigationController?.popViewController(animated: true)
    }

}


