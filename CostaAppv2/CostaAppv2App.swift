//
//  CostaAppv2App.swift
//  CostaAppv2
//
//  Created by HCD Student on 2/21/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CostaAppv2App: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //var clubs:[Club] = fetchData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
/*
func fetchData()->[Club]{
    let db = Firestore.firestore()
    var clubList = [Club]()
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
                
                clubList.append(club)
            }
        }
    }
    print(clubList)
    return clubList
}
*/
