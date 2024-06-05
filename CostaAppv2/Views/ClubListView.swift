
//
//  ClubsView.swift
//  CostaAppv2
//
//  Created by HCD Student on 2/21/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CategoryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(13.5)
            .background(Color(red: 0.82, green: 0.82, blue: 0.82))
            .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
            .font(Font.custom("Inter", size: 14))
            .cornerRadius(12)
    }
}
//make button change color once selected

struct CategoryButtonSelected: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(13.5)
            .background(Color(red: 1, green: 0.82, blue: 0.82))
            .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
            .font(Font.custom("Inter", size: 14))
            .cornerRadius(12)
    }
}


struct ClubListView: View {
    @ObservedObject var vm = ClubViewModel()
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    //@State var buttonStyle : any ButtonStyle = CategoryButton()

    var body: some View {
        ZStack{
            VStack(alignment:.leading){
                HStack(){
                    Text("CLUBS")
                        .padding(.leading, 30)
                        .padding([.top,.bottom], 4)
                        .font(Font.custom("Inter", size: 24).weight(.bold))
                        .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                }
                TextField("Search", text: $vm.searchText)
                    .padding(.leading, 20)
                    .frame(width: .infinity, height: 48)
                    .background(.white)
                    .cornerRadius(10)
                    .padding([.leading,.trailing], 30)
                //categories
                ScrollView(.horizontal){
                    HStack(spacing:15){
                        ForEach(0..<vm.categories.count){ i in
                            Button(vm.categories[i]) {
                                vm.selectedCategory = vm.categories[i]
                            }
                            .buttonStyle(CategoryButton())
                        }
                    }
                    .padding([.top,.bottom], 10)
                    .padding([.leading,.trailing], 30)
                }
                
                //list of clubs displayed
                NavigationView {
                    ZStack {
                        Color.white
                            .ignoresSafeArea()
                        
                        LazyVGrid(columns: twoColumnGrid){
                                ForEach(vm.filteredClubs){ club in
                                    //check if club is expanded in view model
                                    
                                    ExpandableClubView(club: club)
                    
                                    //Text(club.name)
                                }
                                .listRowSeparator(.hidden)
                            }
                            .onAppear() {
                                self.vm.fetchData()
                                self.vm.filterData()
                            }
                            .scrollContentBackground(.hidden)
                            /*.searchable(text:$vm.searchText)
                             .onSubmit(of: .search) {
                             self.vm.filterData()
                             }*/
                        
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                Spacer()
                /*
                 // First HStack (Search and Filter)
                 HStack {
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
                 List(vm.filteredClubs) { club in
                 //check if club is expanded in view model
                 //ExpandableClubView(isExpanded: club.isExpanded, club: club)
                 }
                 .onAppear() {
                 self.vm.fetchData()
                 self.vm.filterData()
                 }
                 .searchable(text:$vm.searchText)
                 .onSubmit(of: .search) {
                 self.vm.filterData()
                 }
                 }
                 }*/
            }
            //.padding(30)
            .padding([.top,.bottom], 30)
            .background(Color(red: 0.94, green: 0.94, blue: 0.94))
            
            
        }
        
    }
    

}

/*
TextField("Search for club...", text: $vm.searchText)
    .font(.custom("Pix", size: 16)) .padding()
    .background(Color.gray.opacity(0.4))
    .cornerRadius(5)
    .frame(maxWidth: .infinity)*/
//LATER ADD CUSTOM SEARCH BAR
/*
struct SearchedView: View{
    var clubList: [Club]
    
    var body: some View{
        List(clubList) { club in
            //check if club is expanded in view model
            ExpandableClubView(isExpanded: club.isExpanded, club: club)
        }
    }
}
*/

struct ExpandableClubView: View {
    //@State var isExpanded: Bool
    var club: Club
    
    var body: some View {
        VStack() {
            Text(club.name)
            .font(Font.custom("Inter", size: 18).weight(.medium))
            .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
            .padding(.bottom,5)
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 140, height: 130)
            .background(Color(red: 0.94, green: 0.94, blue: 0.94))
            .cornerRadius(10)
            .padding(.bottom, 20)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ")
              .font(Font.custom("Inter", size: 14))
              .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
        }
        .frame(width: 150, height: 270)
                  
        
        /*
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
        .padding()*/
         
    }
}

struct ClubsView_Previews: PreviewProvider {
  static var previews: some View {
    ClubListView()
  }
}
