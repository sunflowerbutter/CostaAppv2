//
//  HomepageOGView.swift
//  Costa App
//
//  Created by HCD Student on 2/1/24.
//
/*
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var isAdmin = false
    
    
    func checkIfUserIsAdmin() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { (document, error) in
            if let error = error {
                print("Error checking admin status: \(error)")
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                self.isAdmin = data?["isAdmin"] as? Bool ?? false
            }
        }
    }
}


struct HomePageOG: View {
    @State private var showAlert = false // Add this state property to your HomePage
    @StateObject private var userVM = UserViewModel()
    @StateObject var announcementManager = AnnouncementManager()
    @State private var selectedText = 0
    @State private var textContent = ""
    @State private var isEditing = false
    @State private var announcementTexts: [String] = []
    @State private var comingUpTexts: [String] = []
    @State private var announcements: [Announcement] = []

    
    init() {
        if let savedAnnouncements = UserDefaults.standard.array(forKey: "announcements") as? [String] {
            self._announcementTexts = State(initialValue: savedAnnouncements)
        }
        if let savedComingUp = UserDefaults.standard.array(forKey: "comingUp") as? [String] {
            self._comingUpTexts = State(initialValue: savedComingUp)
        }
    }

    private func saveTexts() {
        UserDefaults.standard.setValue(announcementTexts, forKey: "announcements")
        UserDefaults.standard.setValue(comingUpTexts, forKey: "comingUp")
    }
    

    var body: some View {
        ZStack {
            Color(red: 0, green: 0.3, blue: 0).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white)
                    .frame(height: UIScreen.main.bounds.height * 0.7)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(red: 1, green: 0.8, blue: 0))
                .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2)
                .padding(.bottom, 425)
                .shadow(radius: 5)
            
            Image("costas_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 5)
                .offset(y: -280)
            
            VStack {
                Spacer().frame(height: 250)
                HStack {
                    Text("Announcements")
                        .fontWeight(selectedText == 0 ? .bold : .regular)
                        .foregroundColor(selectedText == 0 ? Color.blue : Color.gray)
                        .underline(selectedText == 0)
                        .onTapGesture {
                            selectedText = 0
                        }

                    Text("Coming Up")
                        .fontWeight(selectedText == 1 ? .bold : .regular)
                        .foregroundColor(selectedText == 1 ? Color.blue : Color.gray)
                        .underline(selectedText == 1)
                        .onTapGesture {
                            selectedText = 1
                        }
                }

                List {
                    if selectedText == 0 {
                        ForEach(announcementTexts.indices, id: \.self) { index in
                            HStack {
                                Text(announcementTexts[index])
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        announcementTexts.remove(at: index)
                                        saveTexts()
                                    }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                         
                    }
                    else {
                        
                        ForEach(comingUpTexts.indices, id: \.self) { index in
                            HStack {
                                Text(comingUpTexts[index])
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        comingUpTexts.remove(at: index)
                                        saveTexts()
                                    }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                         
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Only allow editing if the user is an admin
                        if userVM.isAdmin {
                            isEditing.toggle()
                        } else {
                            showAlert = true
                            // Handle the case when the user is not an admin, e.g., show an alert
                            // You might need to add additional state properties to handle alert visibility
                        }
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color(red: 0, green: 0.3, blue: 0))
                                .shadow(radius: 10)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 70, height: 70)
                    }
                    .padding()

                }
            }

            VStack {
                TextField("Type here...", text: $textContent)
                    .padding()
                    .keyboardType(.default)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))

                HStack {
                    Button(action: {
                        isEditing = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    .padding(.leading)

                    Spacer()

                    Button(action: {
                        if selectedText == 0 {
                            announcementTexts.insert(textContent, at: 0)
                        } else {
                            comingUpTexts.append(textContent)
                        }
                        textContent = ""
                        isEditing = false
                        saveTexts()
                    }) {
                        Text("Publish")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .offset(y: isEditing ? 10 : UIScreen.main.bounds.height)
            .animation(.spring(), value: isEditing)
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Unauthorized"),
                    message: Text("You do not have permission to add announcements."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct HomePageOG_Previews: PreviewProvider {
    static var previews: some View {
        HomePageOG()
    }
}

*/
