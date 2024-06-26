//
//  TestView.swift
//  CostaAppv2
//
//  Created by HCD Student on 4/11/24.
//

import SwiftUI
import Foundation

struct TestView: View {
    /*
    init(){
        for family in UIFont.familyNames {
             print(family)
             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }*/
    var body: some View{
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
                    Button(action: {print("pressed")}){
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
    TestView()
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
