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

    @State private var isLoggedIn: Bool = false
    var body: some View {
        mainAppView()
    }
        func mainAppView() -> some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image("home_icon")
                        Text("Home")
                    }
                
                ClubsView()
                    .tabItem {
                        Image("clubs_icon")
                        Text("Clubs")
                    }
                
                ProfileView()
                    .tabItem {
                        Image("profile_icon")
                        Text("Profile")
                    }
            }
            
            VStack {
                Spacer()
                Divider()
                    .padding(.bottom, 55)
            }
        }
    }
}



struct CustomTabBar: View {
    @Binding var selectedTab: String
    @Binding var showCamera: Bool
    
    var body: some View {
        HStack {
            TabBarButton(imageName: "home_icon", text: "Home", selectedTab: $selectedTab, assignedTab: "home")
            TabBarButton(imageName: "clubs_icon", text: "Clubs", selectedTab: $selectedTab, assignedTab: "clubs")
            Button(action: {
                withAnimation {
                    showCamera.toggle()
                }
            }) {
                Image("plus_icon")
            }
            TabBarButton(imageName: "profile_icon", text: "Profile", selectedTab: $selectedTab, assignedTab: "profile")
        }
    }
}

struct TabBarButton: View {
    var imageName: String
    var text: String
    @Binding var selectedTab: String
    var assignedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = assignedTab
        }) {
            VStack {
                Image(imageName)
                Text(text)
            }
        }
    }
}


struct PageView: View {
    let number: Int

    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 200))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    @State static var simulatedIsLoggedIn = false

    static var previews: some View {
        ContentView()
    }
}


/*
struct CameraViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraView

    func makeUIViewController(context: Context) -> CameraView {
        return CameraView()
    }

    func updateUIViewController(_ uiViewController: CameraView, context: Context) {}
}
*/
