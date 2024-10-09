//
//  Task_example1.swift
//  SwiftUI_Concurrency1
//
//  Created by Akshay Kumar on 09/10/24.
//

import SwiftUI

struct Task_example1: View {
    
    var body: some View {
        NavigationStack {
                    VStack {
                        NavigationLink {
                            Task_Chapter()
                        } label: {
                            Text("Hello World")
                        }
                    }
                    .onAppear {
                     
                    }
                    .onDisappear {
                        print("ContentView disappeared!")
                    }
                }
        
    }
    func call() async {
        let user = User()
        await user.login()
    }
    
}

actor User {
    func login() {
        Task {
            if authenticate(user: "ak", password: "123") {
                
            }
        }
    }
    func authenticate(user:String , password: String) -> Bool {
        return true
    }
}

actor User1TaskDetached {
    func login() {
        Task.detached {
            if await self.authenticate(user: "ak", password: "123") {
                
            }
        }
    }
    func authenticate(user:String , password: String) -> Bool {
        return true
    }
}

#Preview {
    Task_example1()
}
