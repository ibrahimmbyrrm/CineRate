//
//  CommentViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 10.06.2023.
//

import Foundation

class CommentViewModel {
    let comment : Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
}

extension CommentViewModel {
    var owner : String {
        return comment.owner
    }
    var date : String {
        return comment.date
    }
    var commentContent : String {
        return comment.comment
    }
}
