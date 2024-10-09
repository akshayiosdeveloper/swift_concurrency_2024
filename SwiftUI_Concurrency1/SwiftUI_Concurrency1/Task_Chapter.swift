//
//  Task_Chapter.swift
//  SwiftUI_Concurrency1
//
//  Created by Akshay Kumar on 04/10/24.
//

import SwiftUI

struct NewsItem: Decodable,Identifiable {
    let id: Int
    let title: String
    let url: URL
    
}

struct HighScore: Decodable {
    let name: String
    let score: Int
}

struct MessageFormat: Decodable , Identifiable {
    let id: Int
    let from: String
    let text: String
}


struct Task_Chapter: View {
    //@State var newsItems = [NewsItem]()
    @State private var messages = [MessageFormat]()
    var body: some View {
        NavigationView {
            Group {
                if messages.isEmpty {
                    Button("Load Messages") {
                        Task {
                            await loadMessages()
                        }
                    }

                } else {
                    List(self.messages) { message in
                        VStack(alignment: .leading) {
                            Text(message.from)
                                .font(.headline)
                            Text(message.text)
                        }
                        
                    }
                    
                    
                }
            }
            .navigationTitle("inbox")
        }
    }
    func fetchUpdates() async {
        let newsTask = Task { () -> [NewsItem] in
            let url = URL(string: "https://hws.dev/headlines.json")!
            let (data , _) = try await URLSession.shared.data(from: url)
            return  try JSONDecoder().decode([NewsItem].self, from: data)
        }
        
        let highScoreTask = Task { () -> [HighScore] in
            let url = URL(string: "https://hws.dev/scores.json")!
            let (data , _) = try await URLSession.shared.data(from: url)
            return  try JSONDecoder().decode([HighScore].self, from: data)
        }

        do {
            let news = try await newsTask.value
            let highScore = try await highScoreTask.value
            print("Latest news loaded with \(news.count)")
            if let topscore = highScore.first {
                print("\(topscore.name) has highest score")
            }
            
        } catch {
            print("there was error")
        }
        
    }
    func loadMessages() async {
        do {
            let url = URL(string: "https://hws.dev/messages.json")!
            print(url)
            let (data , _) = try await URLSession.shared.data(from: url)
            self.messages =  try JSONDecoder().decode([MessageFormat].self, from: data)
            print(self.messages)
        } catch {
            print("error ")
        }
       
    }
}

#Preview {
    Task_Chapter()
}
