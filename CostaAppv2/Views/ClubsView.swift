//
//  ClubsView.swift
//  CostaAppv2
//
//  Created by HCD Student on 2/21/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct CategorySelectionView: View {
    @Binding var selectedCategory: String?
    @Binding var showingCategorySelection: Bool

    var categories: [String]
    
    var body: some View {
        VStack {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    showingCategorySelection = false
                }) {
                    Text(category)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                }
            }
            Button(action: {
                selectedCategory = nil
                showingCategorySelection = false
            }) {
                Text("All")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
            }
        }
    }
}


struct ExpandableClubView: View {
    @Binding var isExpanded: Bool
    @Binding var followedClubs: [String]
    var club: Club
    
    var isFollowed: Bool {
        followedClubs.contains(club.id!)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        Text(club.name).font(.headline)
                            .font(.custom("pix", size: 16))

                    }
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        if isFollowed {
                            followedClubs.removeAll { $0 == club.id }
                        } else {
                            followedClubs.append(club.id!)
                        }
                    }
                }) {
                    Image(systemName: isFollowed ? "heart.fill" : "heart")
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if isExpanded {
                // Display the club info when expanded
                VStack(alignment: .leading) {
                    Text(club.advisor).font(.subheadline)
                    Text(club.clubLeaders).font(.subheadline)
                    Text(club.day).font(.subheadline)
                    Text("Location/Room Number: \(club.location)").font(.subheadline)
                }
            }
        }
        .padding()
    }
}












struct ClubsView: View {
    @State var clubs: [Club] = []
    @State var searchText: String = ""
    @State var selectedCategory: String? = nil
    @State var categories: [String] = []
    @State var tabSelection: String = "For You"
    @State var followedClubs: [String] = []
    @State private var showingCategorySelection = false


    var filteredClubs: [Club] {
            var result = clubs


            if tabSelection == "Following" {
                result = result.filter { followedClubs.contains($0.id!) }
            } else {
                if !searchText.isEmpty {
                    result = result.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                }
                
                if let selectedCategory = selectedCategory {
                    result = result.filter { $0.category == selectedCategory }
                }
            }
            
            return result
        }


    var body: some View {
        VStack {
            // First HStack (Search and Filter)
            HStack {
                TextField("Search for club...", text: $searchText)
                    .font(.custom("Pix", size: 16))                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                
                Button(action: {
                    showingCategorySelection.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .imageScale(.large)
                        .padding()
                }
                .sheet(isPresented: $showingCategorySelection) {
                    CategorySelectionView(selectedCategory: $selectedCategory, showingCategorySelection: $showingCategorySelection, categories: categories)
                }


            }
                .padding(.horizontal)
            
            // Second HStack (For You / Following)
            HStack {
                                Spacer()
                                Button("For You") {
                                    tabSelection = "For You"
                                }
                                .padding()
                                .background(tabSelection == "For You" ? Color.blue : Color.clear)
                                .foregroundColor(tabSelection == "For You" ? .white : .black)
                                .cornerRadius(8)
                                Spacer()
                                Rectangle()
                                    .frame(width: 1, height: 20)
                                    .foregroundColor(.black)
                                Spacer()
                                Button("Following") {
                                    tabSelection = "Following"
                                }
                                .padding()
                                .background(tabSelection == "Following" ? Color.blue : Color.clear)
                                .foregroundColor(tabSelection == "Following" ? .white : .black)
                                .cornerRadius(8)
                                Spacer()
                            }
                            .padding(.horizontal)
            
            // Updated List (Clubs) with ExpandableClubView
            List {
                            ForEach(filteredClubs.indices, id: \.self) { index in
                                ExpandableClubView(
                                    isExpanded: self.$clubs[index].isExpanded,
                                    followedClubs: self.$followedClubs,
                                    club: self.filteredClubs[index]
                                )
                            }
                        }
            .onAppear {
                fetchClubs()
            }
        }
    }






        func fetchClubs() {
            let db = Firestore.firestore()

            db.collection("Clubs").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    clubs.removeAll()
                    categories.removeAll()


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
                        self.clubs.append(club)


                        if let category = data["category"] as? String, !categories.contains(category) {
                            categories.append(category)
                        }
                    }
                }
            }
        }
    }



struct ClubsView_Previews: PreviewProvider {
  static var previews: some View {
    ClubsView()
  }
}





