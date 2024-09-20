//
//  Sequence.swift
//  SwiftUI_Concurrency1
//
//  Created by Akshay Kumar on 19/09/24.
//

import SwiftUI

struct Sequence: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
               // try? await fetchUsers()
               // try? await fetchQuotes()
             //  try? await fetchQuotes1()
                try? await fetchQuotesFilter()
            }
    }
    func fetchUsers() async throws {
        let  url = URL(string: "https://hws.dev/users.csv")!
        var iterator = url.lines.makeAsyncIterator()
        print(iterator)
        if let line = try await iterator.next() {
            print("the first user is \(line)")
        }
        
        for i in 2...5 {
            if let line = try await iterator.next() {
                print("User #\(i): \(line)")
            }
        }
        
        var remainingResult = [String]()
        while let result  = try await iterator.next() {
            remainingResult.append(result)
        }
        print("There were \(remainingResult.count) other users")
//        for try await line in url.lines {
//            print("Received user:\(line)")
//        }
    }
    
    func fetchQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let uppercaseLines = url.lines.map(\.localizedUppercase)
        for try await line in uppercaseLines {
            print(line)
        }
    }
    func fetchQuotes1() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let quotes = url.lines.map(Quote.init)
        for try await quote in quotes {
            print(quote.text)
        }
    }
    func fetchQuotesFilter() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let uppercaseLines = url.lines.filter { $0.contains("Anonymous")}
        for try await line in uppercaseLines {
            print(line)
        }
    }
}
struct Quote {
    let text: String
}
#Preview {
    Sequence()
}
