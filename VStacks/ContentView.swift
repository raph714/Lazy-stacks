//
//  ContentView.swift
//  VStacks
//
//  Created by Raphael DeFranco on 4/2/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let contentItems: Int = 100

    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...contentItems, id: \.self) { count in
                    if count % 2 == 0 {
                        VStackContent(rows: 20, index: count)
                    } else {
                        HStackContent(columns: 20, index: count)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct VStackContent: View {
    let rows: Int
    let index: Int
    
    var body: some View {
        LazyVStack {
            ForEach(1...rows, id: \.self) { count in
                ImageView(index: count, container: index)
            }
        }
    }
}

struct HStackContent: View {
    let columns: Int
    let index: Int
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(1...columns, id: \.self) { count in
                    ImageView(index: count, container: index)
                }
            }
        }
    }
}

struct ImageView: View {
    var index: Int
    var containerIndex: Int
    
    init(index: Int, container: Int) {
        print("View init: Container \(container) Row \(index)")
        self.index = index
        self.containerIndex = container
    }
    
    var body: some View {
        VStack {
            let _ = Self._printChanges()
            Image("sample")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipped()
        }
    }
}
