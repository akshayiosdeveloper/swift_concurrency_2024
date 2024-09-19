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
               try? await fetchUsers()
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
}

#Preview {
    Sequence()
}
