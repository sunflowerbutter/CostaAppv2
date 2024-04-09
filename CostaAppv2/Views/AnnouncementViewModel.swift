//
//  AnnouncementViewModel.swift
//  CostaAppv2
//
//  Created by HCD Student on 3/21/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AnnouncementViewModel: ObservableObject {
    @Published var clubs = [Club]()
    @Published var filteredClubs = [Club]()
    @Published var announcements = [Announcement]()

    @Published var searchText: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isAdmin = true
    @Published var showCreate = false
    
  
    private var db = Firestore.firestore()
    
    //one time read club data
    func fetchClubData(){
        db.collection("Clubs").getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = document.documentID
                    let advisor = data["advisor"] as? String ?? ""
                    let category = data["category"] as? [String] ?? [""]
                    let clubLeaders = data["clubLeaders"] as? String ?? ""
                    let day = data["day"] as? String ?? ""
                    let leaderEmail = data["leaderEmail"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let newOrOld = data["newOrOld"] as? String ?? ""

                    let club = Club(id: id, advisor: advisor, categories: category, clubLeaders: clubLeaders, day:day, leaderEmail:leaderEmail, location:location, name:name, newOrOld: newOrOld)
                    
                    self.clubs.append(club)
                    self.filteredClubs.append(club)
                }
            }
        }
    }
    
    func filterClubData(){
        if searchText.isEmpty {
            filteredClubs = clubs
        }
        //search present
        else{
            filteredClubs = clubs.filter{ club in
                return club.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func fetchAnnouncementData() {
        db.collection("Announcements").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
     
          self.announcements = documents.map { queryDocumentSnapshot -> Announcement in
            let data = queryDocumentSnapshot.data()
            let title = data["title"] as? String ?? ""
            let content = data["content"] as? String ?? ""
            let clubid = data["clubid"] as? String ?? ""
     
            return Announcement(id: .init(), title: title, content: content, clubid: clubid)
          }
        }
    }
    
    func addAnnouncement(title: String, content: String, clubid: String) {
        let announcement = Announcement(title: title, content: content, clubid: clubid)
        announcements.append(announcement)
        
        let docRef = db.collection("Announcements").document(title+clubid)
        docRef.setData(["title": title, "content": content, "clubid": clubid]) { error in
            if let error = error {
                print("Error writing announcement: \(error)")
            }
            else {
                print("Announcement successfully written!")
            }
        }
      
    }

    func checkAdmin() -> Bool{
        var checkAdmin = false
        Auth.auth().currentUser?.getIDTokenResult(completion: { (result,error) in
            guard let admin = result?.claims["admin"] as? NSNumber else{
                print("No custom claim of admin")
                return
            }
            if admin.boolValue {
                checkAdmin = true
            } else{
                print("User is not an admin")
            }
        })
        return checkAdmin
    }

    
}


        
        /*
        func readAnnouncements(){
            // Read all documents from the collection
            db.collection("Announcements").getDocuments { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let title = document.data()["title"] as? String
                        let content = document.data()["content"] as? String
                        let clubid = document.data()["clubid"] as? String
                        self.announcements.append(Announcement(title:title!, content:content!, clubid:clubid!))
                    }
                }
            }
        }
        func listenForAnnouncements(){
            // Listen for real-time updates from the todos collection
            db.collection("Announcements").addSnapshotListener { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let title = document.data()["title"] as? String
                        let completed = document.data()["completed"] as? Bool
                    }
                }
            }
        }
        */
         
        //once hit button, check for admin status for each club
        /*
        func fetchClubs(){
            let db = Firestore.firestore()
            Task{
                do{
                    let club = try await db.document("Clubs").getDocument(as: Club.self)
                    print("Fetched and decoded: \(club)")
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }
        }
         */
    

