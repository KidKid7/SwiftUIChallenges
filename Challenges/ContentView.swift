//
//  ContentView.swift
//  Challenges
//
//  Created by Kid Kid on 1/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                List {
                    NavigationLink("WeSplit") {
                        WeSplit()
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationTitle("Challeges")
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
