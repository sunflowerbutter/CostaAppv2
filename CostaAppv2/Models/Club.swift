//
//  Club.swift
//  Costa App
//
//  Created by HCD Student on 1/8/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Club: Codable {
    @DocumentID var id: String?
    var advisor: String
    var category: String
    var clubLeaders: String
    var day: String
    var leaderEmail: String?
    var location: String
    var name: String
    var newOrOld: String
    var isExpanded: Bool = false
    
    func printClub(){
        print("id: \(String(describing:id)), name: \(name)")
    }
    
}

class ClubManager {
    static let shared = ClubManager()
    private init() { }
    
    private let clubCollection = Firestore.firestore().collection("Clubs")
}
