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

extension View {
    func hiddenConditionally(isHidden: Bool) -> some View {
        isHidden ? AnyView(self.hidden()) : AnyView(self)
    }
}

struct HomeView: View {
    @ObservedObject var vm = AnnouncementViewModel()
    @State private var plusToggle = false
    var body: some View{
        VStack{
            HStack{
                Text("Announcements")
                    .font(.headline)
                Button(action: {vm.showCreate.toggle()}){
                    Image(systemName: "pencil")
                }
                .hiddenConditionally(isHidden: plusToggle)
                .sheet(isPresented: $vm.showCreate) {
                    CreateAnnouncementView(vm:vm)
                }
            }
            NavigationView{
                List(vm.announcements) { announcement in
                    AnnouncementView(announcement:announcement)
                }
                .onAppear(){
                    vm.fetchAnnouncementData()
                }
            }
        }
    }
}

struct CreateAnnouncementView: View {
    @ObservedObject var vm: AnnouncementViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var clubid: String = ""
    @State private var selectedClub: String?

    @State private var showingDropdown = false
    //@State private var isHovered: Bool = false
    
    var body: some View{
        VStack{
            Text("Create An Announcement")
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Relevant Information", text: $content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            HStack{
                Text(selectedClub ?? "Select a Club")
                Image(systemName: "arrowtriangle.down.fill")
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(showingDropdown ? 180:0))
            }
                .padding()
                .cornerRadius(8)
                .border(.gray)
                .onTapGesture{
                    withAnimation{self.showingDropdown.toggle()}
                }
            if showingDropdown{
                VStack(spacing:10){
                    TextField("Search for a club", text: $vm.searchText)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of:vm.searchText){
                            self.vm.filterClubData()
                        }
                    List(vm.filteredClubs) { club in
                        Button(action:{
                            withAnimation{
                                self.selectedClub = club.name
                                self.showingDropdown.toggle()
                            }
                        }){
                            Text(club.name)
                        }
                    }
                    .onAppear() {
                        self.vm.fetchClubData()
                    }
                }
            }
            //add error messages
            Button("Create Announcement"){
                if title.isEmpty{
                    print("Please add a title")
                }
                else if content.isEmpty{
                    print("Please add the content of your announcement")
                }
                else if selectedClub == nil{
                    print("Please choose a club")
                }
                else{
                    vm.addAnnouncement(title: title, content: content, clubid: clubid)
                    vm.showCreate.toggle()
                }
            }
                .padding()
                .cornerRadius(8.0)
        }
    }
}


#Preview {
    HomeView()
    //CreateAnnouncementView(vm:AnnouncementViewModel())
}

/*
 .shadow(color: .gray.opacity(0.4), radius: 4, x:0, y:2)

 */
