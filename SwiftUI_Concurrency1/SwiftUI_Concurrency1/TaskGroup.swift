//
//  TaskGroup.swift
//  SwiftUI_Concurrency1
//
//  Created by Akshay Kumar on 24/10/24.
//

import SwiftUI

struct TaskGroup: View {
    var body: some View {
        Text("a")
            .task {
              let str =  await self.printMessage()
               print(str)
            }
       // self.printMessage()
    }
    
    func printMessage() async {
        let string = await withTaskGroup(of: String.self) { group -> String in
            group.addTask {
                "1"
            }
            group.addTask {
                "2"
            }
            group.addTask {
                "3"
            }
            var collected = [String]()
            for await value in group {
                collected.append(value)
            }
            return collected.joined(separator: " ")
            
        }
        print(string)
    }
}


#Preview {
    TaskGroup()
}
