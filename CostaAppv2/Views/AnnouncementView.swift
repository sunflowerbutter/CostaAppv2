//
//  AnnouncementView.swift
//  Costa App
//
//  Created by HCD Student on 1/23/24.
//

import SwiftUI

struct AnnouncementView: View {
    var announcement: Announcement

    var body: some View {
        VStack(alignment: .leading) {
            Text(announcement.title)
                .font(.headline)
                .foregroundColor(.blue)

            Text(announcement.content)
                .font(.body)
                .foregroundColor(.black)
                .padding(.top, 4)

        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    AnnouncementView(announcement: Announcement(title: "title", content: "content", clubid: "clubid"))
}


