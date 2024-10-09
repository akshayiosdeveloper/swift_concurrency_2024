//
//  Task_Chapter1.swift
//  SwiftUI_Concurrency1
//
//  Created by Akshay Kumar on 09/10/24.
//

import SwiftUI

struct Task_Chapter1: View {
    @State private var name = "akshay"
    var body: some View {
        Text(name)
        Button("Task") {
            Task {
                name = "Taylor"
            }
        }
        Spacer()
        Button("Detached task") {
            Task.detached {
                name = "detach"
            }
        }
    }
}

#Preview {
    Task_Chapter1()
}
