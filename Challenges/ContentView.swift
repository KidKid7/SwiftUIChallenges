//
//  ContentView.swift
//  Challenges
//
//  Created by Kid Kid on 1/20/23.
//

import SwiftUI


struct CustomNavigationLink<Destination: View> : View {
    let title: String
    let index: Int
    let destination: () -> Destination
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HStack {
                Image(systemName: "\(index).circle")
                Text(title)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                List {
                    CustomNavigationLink(title: "WeSplit", index: 1) {
                        WeSplit()
                    }
                    
                    CustomNavigationLink(title: "GuessTheFlag", index: 2) {
                        GuessTheFlag()
                    }
                    
                    CustomNavigationLink(title: "ViewsAndModifiers", index: 3) {
                        ViewsAndModifiers()
                    }
                    
                    CustomNavigationLink(title: "BetterRest", index: 4) {
                        BetterRest()
                    }
                    
                    CustomNavigationLink(title: "WordScramble", index: 5) {
                        WordScramble()
                    }
                    
                    CustomNavigationLink(title: "Animation", index: 6) {
                        Animation()
                    }
                }
                .font(.subheadline)
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
