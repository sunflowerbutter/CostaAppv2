//
//  ContentView.swift
//  CostaAppv2
//
//  Created by HCD Student on 2/21/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore


struct ContentView: View {
    @State private var selectedTab : Tab = .house
    //hide natural tab bar
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack{
            VStack{
                TabView(selection: $selectedTab){
                    ForEach(Tab.allCases, id:\.rawValue){ tab in
                        HStack{
                            if (tab.rawValue == "house"){
                                HomeView()
                            }
                            else if (tab.rawValue == "archivebox"){
                                ClubListView()
                            }
                            else if (tab.rawValue == "person"){
                                ProfileView()
                            }
                        }
                        .tag(tab)
                    }
                }
            }
            VStack{
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }
    
}

enum Tab: String, CaseIterable{
    case house
    case archivebox
    case person
}

struct CustomTabBar: View{
    @Binding var selectedTab: Tab
    private var fillImage: String{
        selectedTab.rawValue+".fill"
    }
    var body: some View{
        VStack{
            HStack{
                ForEach(Tab.allCases, id:\.rawValue){ tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? .green : .gray)
                        .font(.system(size: 22))
                        .onTapGesture{
                            withAnimation(.easeIn(duration: 0.1)){
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height:60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    //@State static var simulatedIsLoggedIn = false

    static var previews: some View {
        ContentView()
    }
}

