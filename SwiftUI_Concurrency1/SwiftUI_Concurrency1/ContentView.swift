//
//  ContentView.swift
//  SwiftUI_Concurrency1
//
//  Created by Akshay Kumar on 11/04/24.
//

import SwiftUI

struct ContentView: View {
    let source = RemoteFile(url: URL(string: "https://hws.dev/inbox.json")!, type: [Message].self)
    @State private var messages = [Message]()
    
    var body: some View {
        NavigationStack {
            List(messages) { message in
                VStack {
                    Text(message.user)
                        .font(.headline)
                    Text(message.text)
                }
                .navigationTitle("Inbox")
                .toolbar {
                    Button(action: {
                       refresh()
                    }, label: {
                       Label("Refresh", image: "arrow.clockwise")
                    })
                }
                .onAppear(perform: {
                    refresh()
                })
                
            }
        }
    }
    func refresh() {
        Task {
            do {
                messages = try await  source.contents
            } catch {
                print("Message update failed")
            }
        }
    }
}

#Preview {
    ContentView()
}

struct RemoteFile<T: Decodable > {
    let url: URL
    let type: T.Type
    var contents: T {
        get async throws {
            let (data,_) = try await URLSession.noCacheSession.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
}

struct Message: Decodable , Identifiable {
    let id: Int
    let user: String
    let text: String
}
extension URLSession {
    static let noCacheSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.requestCachePolicy
           
        = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
       
    }()
}
