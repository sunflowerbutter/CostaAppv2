//
//  ContentViewModel.swift
//  CostaAppv2
//
//  Created by HCD Student on 3/14/24.
//

import Foundation
import SwiftUI

extension ContentView{
    @MainActor class ContentViewModel: ObservableObject{
        @Published var isLoggedIn: Bool = false
    }
}
