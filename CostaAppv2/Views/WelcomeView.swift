//
//  WelcomeView.swift
//  CostaAppv2
//
//  Created by HCD Student on 2/21/24.
//
import SwiftUI
import Firebase
import FirebaseAuth

struct UserAuthenticationView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            ContentView()
        } else {
            NavigationView {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showCreateAccount = false

    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    
                    Image("costas_icon")
                        .resizable()
                        .position(x: 175, y: 180)
                        .frame(width: 300, height: 300)
                }
                Text("Login")
                    .position(x: 150, y: 10)
                    .font(.system(size: 40, weight: .bold))
                    .padding(.leading, 30)
                
                Text("Please sign in to continue")
                    .position(x: 160, y: 10)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                                .position(x: 140, y: 50)
                        )
                    
                    TextField("Email", text: $email)
                        .padding(.horizontal, 50)
                        .frame(height: 10)
                        .position(x: 135, y: 50)

                    
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        .padding(.leading, 15)
                        .position(x: 15, y: 50)

                }
                .padding([.leading, .trailing, .top], 40)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    SecureField("Password", text: $password)
                        .padding(.horizontal, 40)
                        .frame(height: 50)
                    
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                        .padding(.leading, 15)
                }
                .padding([.leading, .trailing, .top], 40)
                
                HStack {
                    Toggle("Remember Me", isOn: $rememberMe)
                    Spacer()  // Spacer to push them apart
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                    }
                    .foregroundColor(.blue)
                    
                    .foregroundColor(.blue)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                HStack {
                    Spacer() // Pushes the button to the right
                    Button(action: {
                        performLogin()
                    }) {
                        HStack {
                            Text("Login")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .frame(width: 80, height: 40) // Specific frame size for the button
                    .fontWeight(.bold)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                }
                .padding(.top, 20)
                
                Spacer()  // Pushes the content down
                
                
                NavigationLink("", destination: CreateAccountView(), isActive: $showCreateAccount).hidden()
                
                HStack {
                    Spacer()  // Centers the text horizontally
                    Button("Don't have an account? Sign Up") {
                        showCreateAccount = true
                    }
                    .foregroundColor(.blue)
                    Spacer()  // Centers the text horizontally
                }
            }
            .padding(.horizontal)
            .padding(.top, -50) // Adjust this value as needed
        }
    }

    func performLogin() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in: \(error)")
                return
            }
            
            if let user = Auth.auth().currentUser {
                if user.isEmailVerified {
                    isLoggedIn = true
                } else {
                    // alert
                    print("Please verify your email before proceeding.")
                }
            }
        }
    }
    
    func forgotPassword() {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Failed to send reset email: \(error)")
                    return
                }
                print("Password reset email sent.")
            }
        }

}



struct CreateAccountView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showVerificationAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 80)
                .padding(.leading, 20)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                TextField("Name", text: $name)
                    .padding(.horizontal, 50)
                    .frame(height: 30)
                
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
            }
            .padding([.leading, .trailing, .top], 20)
            
            
            
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                TextField("Email", text: $email)
                    .padding(.horizontal, 50)
                    .frame(height: 30)
                
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
            }
            .padding([.leading, .trailing, .top], 20)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                SecureField("Password", text: $password)
                    .padding(.horizontal, 40)
                    .frame(height: 50)
                
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
            }
            .padding([.leading, .trailing, .top], 20)
            
            HStack {
                Spacer()
                Button("Create Account") {
                    createAccount()
                }
                .frame(width: 150, height: 40)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(100)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding(.horizontal)
        
        .alert(isPresented: $showVerificationAlert) {
            Alert(title: Text("Verify Email"),
                  message: Text("Please check your email to verify your account. Don't forget to check spam and trash folders."),
                  dismissButton: .default(Text("OK")))
        }

    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create account: \(error)")
                return
            }
            
            // Send email verification
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if let error = error {
                    print("Failed to send verification email: \(error)")
                    return
                }
                print("Verification email sent.")
                showVerificationAlert = true
            }
            
            // Update display name
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = name
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        print("Failed to update display name: \(error)")
                        return
                    }
                    print("Successfully updated display name")
                }
            } else {
                print("Failed to create profile change request")
            }
            
            presentationMode.wrappedValue.dismiss()
        }
    }
}



struct UserAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        UserAuthenticationView()
    }
}
