//
//  FirebaseFirestoreService.swift
//  CineRate
//
//  Created by İbrahim Bayram on 9.06.2023.
//

import Foundation
import Firebase

class FirebaseFirestoreService {
    
    func saveComment(movie : Movie,comment : String) {
        guard Auth.auth().currentUser != nil else {return}
        guard let username = Auth.auth().currentUser?.email?.components(separatedBy: "@").first else {return}
        let firestore = Firestore.firestore()
        let firestoreReference : DocumentReference
        let firestoreData = ["owner" : username,"comment" : comment,"movieId" : movie.id,"date" : FieldValue.serverTimestamp()] as [String : Any]
        firestoreReference = firestore.collection("comments").addDocument(data: firestoreData, completion: { error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print("veri kaydedildi")
            }
        })
    }
    
    func fetchCommentsa(movieID : Int, completion : @escaping([Comment]?)->Void ){
        var list = [Comment]()
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("comments").whereField("movieId", isEqualTo: movieID).order(by: "date",descending: true).addSnapshotListener { snapshot, error in
            guard error == nil && snapshot?.isEmpty != true && snapshot != nil else {return}
            list.removeAll(keepingCapacity: false)
            for document in snapshot!.documents {
                guard let movieId = document.get("movieId") as? Int else {return}
                guard let comment = document.get("comment") as? String else {return}
                guard let date = document.get("date") as? Timestamp else {return}
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                let dateString = dateFormatter.string(from: date.dateValue())
                guard let owner = document.get("owner") as? String else {return}
                let fetchedComment = Comment(movieId: movieID, date: dateString, owner: owner, comment: comment)
                print(fetchedComment)
                list.append(fetchedComment)
            }
            completion(list)
        }
    }
}
