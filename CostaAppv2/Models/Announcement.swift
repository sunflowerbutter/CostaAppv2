//
//  Announcements.swift
//  Costa App
//
//  Created by HCD Student on 1/9/24.
//

import Foundation

struct Announcement: Identifiable{
    var id = UUID()
    var title: String
    var content: String
    var clubid: String
    //var timestamp: String
        //https://stackoverflow.com/questions/46376823/ios-swift-get-the-current-local-time-and-date-timestamp
    //var image
}

//need to somehow store + access all announcements every time the app is rerun from firebase
class AnnouncementManager: ObservableObject{
    //@Published used to automatically update the UI when the announcements are modified.
    @Published var announcements: [Announcement] = []
    
    func addAnnouncement(title: String, content: String, clubid: String) {
        let announcement = Announcement(title: title, content: content, clubid: clubid)
        announcements.append(announcement)
    }
}


