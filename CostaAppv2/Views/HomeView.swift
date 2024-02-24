//
//  AnnouncementView.swift
//  Costa App
//
//  Created by HCD Student on 1/9/24.
//

import SwiftUI
import FirebaseAuth


struct HomeView: View {
    @StateObject var announcementManager = AnnouncementManager()
    /*func updateUI(){
        Auth.auth().currentUser?.getIDTokenResult(completion: { (result,error) in
            guard let admin = result?.claims["admin"] as? NSNumber else{
                self.showRegularUI()
                return
            }
            if admin.boolValue {
                //show mod ui
                self.showModeratorUI()
            } else{
                self.showRegularUI()
            }
        })
    }*/
    var body: some View {
        NavigationStack {
            List(announcementManager.announcements) { announcement in
                AnnouncementView(announcement: Announcement(title: "title", content: "content", clubid: "clubid"))
            }
            .navigationTitle("Announcements")
            .navigationBarItems(trailing:
                            NavigationLink(destination: CreateAnnouncementView(announcementManager: announcementManager)) {
                                Text("Create")
                            }
                        )
        }
    }
}

struct CreateAnnouncementView: View {
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

            TextEditor(text: $content)
                .padding()
                .border(Color.gray, width: 1)
                .cornerRadius(5.0)
            
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
    }
}

#Preview {
    HomeView()
}
