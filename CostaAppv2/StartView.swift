//
//  StartView.swift
//  CostaAppv2
//
//  Created by HCD Student on 4/12/24.
//

import SwiftUI

struct StartView: View {
    @State var goToContent:Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image("CostaTitle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                /*Text("COSTA’S\nCORNER")
                    .font(Font.custom("Wendy One", size: 54))
                    .foregroundColor(Color(red: 0.91, green: 0.45, blue: 0.38))*/
            ZStack(){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, minHeight: 395)
                    .background(Color(hex: "#F7F5EF"))
                    .cornerRadius(55)
                VStack(spacing:20){
                    Text("Keep up to Date!")
                        .font(Font.custom("Poppins", size: 22).weight(.bold))
                        .foregroundColor(Color(hex: "5E9694"))
                    VStack(spacing: 10){
                        Button(action: {print("pressed")}){
                            Text("daily bell schedule")
                                .font(Font.custom("Poppins", size: 18).weight(.medium))
                                .foregroundColor(Color(hex: "5E9694"))
                        }
                        .frame(width: 196, height: 49)
                        .background(Color(hex: "D5E2C0"))
                        .cornerRadius(15)
                        Button(action: {print("pressed")}){
                            Text("discover interesting clubs")
                                .font(Font.custom("Poppins", size: 18).weight(.medium))
                                .foregroundColor(Color(hex: "5E9694"))
                        }
                        .frame(width: 272.95, height: 49)
                        .background(Color(hex: "D5E2C0"))
                        .cornerRadius(15)
                        Button(action: {print("pressed")}){
                            Text("be reminded of school events")
                                .font(Font.custom("Poppins", size: 18).weight(.medium))
                                .foregroundColor(Color(hex: "5E9694"))
                        }
                        .frame(width: 308.52, height: 49)
                        .background(Color(hex: "D5E2C0"))
                        .cornerRadius(15)
                    }
                    Button(action: {goToContent = true}){
                        Text("ENTER")
                            .font(Font.custom("Poppins", size: 20).weight(.bold))
                            .foregroundColor(Color(red: 0.91, green: 0.45, blue: 0.38))
                    }
                    .frame(width: 138, height: 49)
                    .background(Color(hex:"FFC482"))
                    .cornerRadius(15)
                }
            }
            .frame(alignment:.bottom)
        }
        .padding(EdgeInsets(top: 63, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "FFC482"))
    }
}

#Preview {
    StartView()
}
