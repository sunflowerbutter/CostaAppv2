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

    class AnnouncementViewModel: ObservableObject{
        private var db = Firestore.firestore()
        
        @Published var isLoggedIn: Bool = false
        @Published var announcements = [Announcement]()
        @Published var isAdmin = true
        
        //create
        @Published var allClubs:[Club] = []
        @Published var searchText = ""
        
        
        var allClubNames: [String] {
            var names:[String] = []
            for club in allClubs{
                names.append(club.name)
            }
            return names
        }
        /*
        var filteredClubs: [String] {
                    searchText.isEmpty ? allClubNames : allClubNames.filter{
                $0.localizedCaseInsensitiveContains(searchText)}
        }*/
        
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
        func fetchData() {
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
        func addAnnouncementAsync(title: String, content: String, clubid: String) {
            let announcement = Announcement(title: title, content: content, clubid: clubid)
            Task {
            do {
              let ref = try await db.collection("Announcements").addDocument(data: [
                "id": announcement.id,
                "title": announcement.title,
                "content": announcement.content,
                "clubid": announcement.clubid
              ])
              print("Document added with ID \(ref.documentID)")
            }
            catch {
              print(error.localizedDescription)
            }
          }
        }

        func addAnnouncement(title: String, content: String, clubid: String) {
            //let announcement = Announcement(title: title, content: content, clubid: clubid)
            //announcementList.append(announcement)
            
            
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
    }

