//
//  BookView.swift
//  CostaAppv2
//
//  Created by HCD Student on 3/25/24.
//

import Foundation
import FirebaseFirestore
import SwiftUI

struct Book: Identifiable {
  var id: String = UUID().uuidString
  var title: String
  var author: String
}

class BooksViewModel: ObservableObject {
  @Published var books = [Book]()
  
  private var db = Firestore.firestore()
  
  func fetchData() {
    db.collection("Books").addSnapshotListener { (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("No documents")
        return
      }
 
      self.books = documents.map { queryDocumentSnapshot -> Book in
        let data = queryDocumentSnapshot.data()
        let title = data["title"] as? String ?? ""
        let author = data["author"] as? String ?? ""
        return Book(id: .init(), title: title, author: author)
      }
    }
  }
}
struct BooksListView: View {
  @ObservedObject var viewModel = BooksViewModel() // (/1)

    var body: some View {
    NavigationView {
      List(viewModel.books) { book in // (2)
        VStack(alignment: .leading) {
          Text(book.title)
            .font(.headline)
          Text(book.author)
            .font(.subheadline)
        }
      }
      .navigationBarTitle("Books")
      .onAppear() { // (3)
        self.viewModel.fetchData()
      }
    }
  }
}


#Preview {
    //HomeView()
    BooksListView()
}
