//
//  Club.swift
//  Costa App
//
//  Created by HCD Student on 1/8/24.
//

import Foundation

struct Club: Identifiable {
    let id: String
    var advisor: String
    var category: String
    var clubLeaders: String
    var day: String
    var leaderEmail: String?
    var location: String
    var name: String
    var newOrOld: String
    var isExpanded: Bool = false
}
