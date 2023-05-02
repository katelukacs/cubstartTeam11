//
//  User.swift
//  iDecide
//
//  Created by Steven Guo on 5/1/23.
//

import SwiftUI
import Firebase

class User: ObservableObject {
    var id: String
    @Published var decisionItems = [DecisionItem]()
    
    init(id: String) {
        self.id = id
        self.decisionItems = []
    }
    
    func addDecision() {
    }
    
    func fetchDecisions() {
        decisionItems.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("DecisionItem")
        let query = ref.whereField("user", isEqualTo: self.id)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            for document in querySnapshot!.documents {
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let decide = data["decide"] as? Int ?? 0
                
                let decisionItem = DecisionItem(name: name, decide: decide)
                self.decisionItems.append(decisionItem)
            }
        }
    }
}
