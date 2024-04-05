//
//  ClubViewModel.swift
//  CostaAppv2
//
//  Created by HCD Student on 3/25/24.
//

import Foundation
import FirebaseFirestore

class ClubViewModel: ObservableObject {
    @Published var clubs = [Club]()
    @Published var selectedCategory: String = "All"
    @Published var searchText: String = ""
    @Published var categories : [String] = ["CommServ", "Int/Hobbies", "Charity/Don", "Cul Heritage", "Div/Incl", "Sports", "STEM", "Animal", "Music", "Environment", "Art", "Finance", "Politics", "Literary"]
    @Published var filteredClubs = [Club]()
  
    private var db = Firestore.firestore()
    
    //one time read data
    func fetchData(){
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
    
    func filterData(){
        if selectedCategory == "All" && searchText.isEmpty {
            filteredClubs = clubs
        }
        //search present
        else if selectedCategory == "All" {
            filteredClubs = clubs.filter{ club in
                return club.name.lowercased().contains(searchText.lowercased())
            }
        }
        else{
            //category
            filteredClubs = clubs.filter{ club in
                return club.categories.contains(selectedCategory)
            }
            //search
            if !searchText.isEmpty{
                filteredClubs = filteredClubs.filter{ club in
                    return club.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
    }
    
}
