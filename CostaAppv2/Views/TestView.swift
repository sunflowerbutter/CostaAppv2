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
    var body: some View {
        ZStack() {
          Group {
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, maxHeight: 395, alignment:.bottom)
              .background(Color(red: 0.97, green: 0.96, blue: 0.94))
              .cornerRadius(75)
              .offset(x: 0, y: 224.50)
              
              Button(action: {print("pressed")}){
                  Text("ENTER")
                    .font(Font.custom("Poppins", size: 20).weight(.bold))
                    .foregroundColor(Color(red: 0.91, green: 0.45, blue: 0.38))
              }
               .foregroundColor(.clear)
               .frame(width: 138, height: 49)
               .background(Color(red: 1, green: 0.77, blue: 0.51))
               .cornerRadius(15)
               .padding(.bottom, 40)
               .frame(maxHeight: .infinity, alignment: .bottom)
              
            Text("Keep up to Date!")
              .font(Font.custom("Poppins", size: 22).weight(.bold))
              .foregroundColor(Color(red: 0.37, green: 0.59, blue: 0.58))
              .offset(x: 1, y: 100)
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 196, height: 49)
                .background(Color(red: 0.84, green: 0.89, blue: 0.75))
                .cornerRadius(15)
                .offset(x: 1, y: 0)
              Text("daily bell schedule")
                .font(Font.custom("Poppins", size: 18).weight(.medium))
                .foregroundColor(Color(red: 0.37, green: 0.59, blue: 0.58))
                .offset(x: 0.50, y: 0.50)
            }
            .frame(width: 270, height: 49)
            .offset(x: 0, y: 156.50)
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 272.95, height: 49)
                .background(Color(red: 0.84, green: 0.89, blue: 0.75))
                .cornerRadius(15)
                .offset(x: 1.39, y: 0)
              Text("discover interesting clubs")
                .font(Font.custom("Poppins", size: 18).weight(.medium))
                .foregroundColor(Color(red: 0.37, green: 0.59, blue: 0.58))
                .offset(x: 0.70, y: 0.50)
            }
            .frame(width: 376, height: 49)
            .offset(x: 8, y: 217.50)
          }
            Text("COSTA’S\nCORNER")
              .font(Font.custom("Wendy One", size: 54))
              .foregroundColor(Color(red: 0.91, green: 0.45, blue: 0.38))
              .offset(x: 1, y: -168)
          Group {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 308.52, height: 49)
                .background(Color(red: 0.84, green: 0.89, blue: 0.75))
                .cornerRadius(15)
                .offset(x: 1.57, y: 0)
              Text("be reminded of school events")
                .font(Font.custom("Poppins", size: 18).weight(.medium))
                .foregroundColor(Color(red: 0.37, green: 0.59, blue: 0.58))
                .offset(x: 0.79, y: 0.50)
            }
            .frame(width: 425, height: 49)
            .offset(x: 0.50, y: 280.50)
          }
        }
        .frame(width: 390, height: 844)
        .background(Color(red: 1, green: 0.77, blue: 0.51))
        .cornerRadius(40)
    }
}

#Preview {
    TestView()
}
