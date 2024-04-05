
//
//  ClubsView.swift
//  CostaAppv2
//
//  Created by HCD Student on 2/21/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

/*
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
}*/
struct ExpandableClubView: View {
    @State var isExpanded: Bool
    var club: Club
    
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

struct ClubListView: View {
    @ObservedObject var vm = ClubViewModel()
    //@State private var showingCategorySelection = false

    var body: some View {
        VStack {
            // First HStack (Search and Filter)
            HStack {
                TextField("Search for club...", text: $vm.searchText)
                    .font(.custom("Pix", size: 16)) .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(5)
                    .frame(maxWidth: .infinity)
                
                Button(action:{(vm.selectedCategory="All");                    vm.filterData()}){
                    Text("All")
                }
                Button(action:{(vm.selectedCategory="CommServ");                    vm.filterData()}){
                    Text("Community Service")
                }
                Button(action:{(vm.selectedCategory="Int/Hobbies");                    vm.filterData()}){
                    Text("Interest/Hobby")
                }
            }
                .padding(.horizontal)
                .padding(.top, 10)
            
            NavigationView {
                
            }
            /*
            NavigationView {
                List(vm.filteredClubs) { club in
                    //check if club is expanded in view model
                    ExpandableClubView(isExpanded: club.isExpanded, club: club)
                }
                .onAppear() {
                    self.vm.fetchData()
                }
                .searchable(text:$vm.searchText)
                .onSubmit(of: .search) {
                    self.vm.filterData()
                }
            }*/
        }
        
    }
}

private struct SearchedView: View{
    var vm: ClubViewModel
    
    var body: some View{
        List(vm.filteredClubs) { club in
            //check if club is expanded in view model
            ExpandableClubView(isExpanded: club.isExpanded, club: club)
        }
    }
}




struct ClubsView_Previews: PreviewProvider {
  static var previews: some View {
    ClubListView()
  }
}






/*
var filteredClubs: [Club] {
    var result = clubs
        if tabSelection == "Following" {
            result = result.filter { followedClubs.contains($0.id) }
        }
        else {
            if !searchText.isEmpty {
                result = result.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
            if let selectedCategory = selectedCategory {
                result = result.filter { $0.category == selectedCategory }
            }
        }
    return result
}*/

