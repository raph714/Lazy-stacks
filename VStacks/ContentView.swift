//
//  ContentView.swift
//  VStacks
//
//  Created by Raphael DeFranco on 4/2/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let contentItems: Int = 10000

    @ObservedObject var viewModel = SomeVM()

    var body: some View {
        VStack {
            Button {
                viewModel.update()
            } label: {
                Text("update")
            }

            let _ = Self._printChanges()

            ScrollView {
                LazyVStack {
                    ForEach(viewModel.names, id: \.self) { name in
                        HStackContent(columns: 3, index: 1, name: name)
                        //                    if count % 2 == 0 {
                        //                        VStackContent(rows: 20, index: count)
                        //                    } else {
                        //                        HStackContent(columns: 20, index: count)
                        //                    }
                    }
                }
            }
        }
    }
}

class SomeVM: ObservableObject {
    @Published var names: [String] = ["1"]
    private var num = 1

    func update() {
        num += 1
//        names.append("\(num)")
        names.insert(contentsOf: ["\(num)"], at: 0)
    }
}

#Preview {
    ContentView()
}

struct VStackContent: View {
    let rows: Int
    let index: Int
    let name: String

    var body: some View {
        LazyVStack {
            ForEach(1...rows, id: \.self) { count in
                ImageView(index: count, container: index, title: name)
            }
        }
    }
}

struct HStackContent: View {
    let columns: Int
    let index: Int
    let name: String

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(1...columns, id: \.self) { count in
                    ImageView(index: count, container: index, title: name)
                }
            }
        }
    }
}

struct ImageView: View {
    var index: Int
    var containerIndex: Int
    var title: String

    init(index: Int, container: Int, title: String) {
        print("View init: Container \(container) Row \(index)")
        self.index = index
        self.containerIndex = container
        self.title = title
    }
    
    var body: some View {
        VStack {
            let _ = Self._printChanges()
            Text("View init: Container \(containerIndex) Row \(index)")
            Text(title)
            Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
                .frame(width: 200, height: 200)
                .cornerRadius(8)
        }
    }
}
