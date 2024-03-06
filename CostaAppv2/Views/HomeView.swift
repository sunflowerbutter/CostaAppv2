//
//  AnnouncementView.swift
//  Costa App
//
//  Created by HCD Student on 1/9/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

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

struct HomeView: View {
    @StateObject var announcementManager = AnnouncementManager()
    @State private var isAdmin = true
    
    var body: some View {
        //admin view
        if(isAdmin){
            NavigationStack {
                List(announcementManager.announcements) { announcement in
                    AnnouncementView(announcement: Announcement(title: "title", content: "content", clubid: "clubid"))
                }
                .navigationTitle("Announcements")
                .navigationBarItems(trailing:
                                        NavigationLink(destination: CreateAnnouncementView(announcementManager:announcementManager)){Text("Create")})
                
            }
        }
        //normal view
        else{
            NavigationStack {
                List(announcementManager.announcements) { announcement in
                    AnnouncementView(announcement: Announcement(title: "title", content: "content", clubid: "clubid"))
                }
                .navigationTitle("Announcements")
            }
        }
    }
}

struct CreateAnnouncementView: View {
    @State private var allClubs:[Club] = []
    @State private var searchText = ""
    @State private var selectedClub: String?
    @State private var showingDropdown = false
    @State private var isHovered: Bool = false
    
    var allClubNames: [String] {
        var names:[String] = []
        for club in allClubs{
            names.append(club.name)
        }
        return names
    }
    var filteredClubs: [String] {
                searchText.isEmpty ? allClubNames : allClubNames.filter{
            $0.localizedCaseInsensitiveContains(searchText)}
    }
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var clubid: String = ""
    @StateObject var announcementManager: AnnouncementManager
    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Relevant Information", text: $content)
                .padding()
                .border(Color.gray, width: 1)
                .cornerRadius(5.0)
            
            HStack{
                Text(selectedClub ?? "Select a Club")
                    .foregroundColor(.primary)
                    .font(.headline)
                Spacer()
                Image(systemName: showingDropdown ? "arrowtriangle.up.fill":"arrowtriangle.down.fill")
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(showingDropdown ? 0:180))

            }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.4), radius: 4, x:0, y:2)
                .onTapGesture{
                    withAnimation{
                        self.showingDropdown.toggle()
                    }
                }
            if showingDropdown{
                VStack(spacing:10){
                    TextField("Search for a club", text: $searchText)
                        .padding(.horizontal,16)
                        .padding(.vertical,10)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray.opacity(0.4), radius: 4, x:0, y:2)
                        .foregroundColor(.primary)
                    
                    List(filteredClubs, id:\.self){club in
                        Button(action: {
                            withAnimation{
                                self.selectedClub = club
                                self.showingDropdown.toggle()
                            }
                        }){
                            Text(club)
                                .foregroundColor(.primary)
                        }
                    }
                    .frame(maxHeight:150)
                }
                .padding(.horizontal,16)
            }
            
            if let selectedClub = selectedClub {
                Text("Selected Club: \(selectedClub)")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
            }
            TextEditor(text: $clubid)
                .padding()
                .border(Color.gray, width: 1)
                .cornerRadius(5.0)
            Button("Create Announcement") {
                announcementManager.addAnnouncement(title: title, content: content, clubid: clubid)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8.0)
            .padding()
        }
        .navigationTitle("Create Announcement")
        //.background(.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
    /*func fetchClubs(){
        let db = Firestore.firestore()

        db.collection("Clubs").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let club = Club(
                        id: document.documentID,
                        advisor: data["advisor"] as? String ?? "",
                        category: data["category"] as? String ?? "",
                        clubLeaders: data["clubLeaders"] as? String ?? "",
                        day: data["day"] as? String ?? "",
                        leaderEmail: data["leaderEmail"] as? String ?? "",
                        location: data["location"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        newOrOld: data["newOrOld"] as? String ?? ""
                    )
                    allClubs.append(club)
                }
            }
        }
    }*/
}


//modify to make one global function



#Preview {
    //HomeView()
    CreateAnnouncementView(announcementManager: AnnouncementManager())
}
