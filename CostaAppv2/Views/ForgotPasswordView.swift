//
//  ForgetPasswordView.swift
//  Costa App
//
//  Created by Colton Spyker on 10/17/23.
//


import SwiftUI
import Firebase
import FirebaseAuth


struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

            Button("Reset") {
                sendResetEmail()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(false)
    }

    func sendResetEmail() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertTitle = "Error"
                alertMessage = "Failed to send reset email: \(error.localizedDescription)"
                showAlert = true
                return
            }
            alertTitle = "Success"
            alertMessage = "Password reset email sent."
            showAlert = true
            presentationMode.wrappedValue.dismiss()
        }
    }
}
