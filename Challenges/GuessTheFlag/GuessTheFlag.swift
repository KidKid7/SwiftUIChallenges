//
//  GuessTheFlag.swift
//  Challenges
//
//  Created by Kid Kid on 1/20/23.
//

import SwiftUI

struct GuessTheFlag: View {
    
    @State private var reset = false
    @State private var nbOfTry = 0
    @State private var score = 0
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var randomFlag = Int.random(in: 0..<3)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var selectedIndex = -1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.2),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0), location: 0.2)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                Text("Guess The Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                VStack {
                    VStack(spacing: 5) {
                        Text("Tap on the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[randomFlag])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    VStack(spacing: 25) {
                        ForEach(0..<3) { index in
                            Button {
                                selectedIndex = index
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    flagTapped(index: index)
                                }
                            } label: {
                                FlagImage(name: countries[index])
                            }
                            .opacity(selectedIndex == index || selectedIndex == -1
                                     ? 1
                                     : 0.75
                            )
                            .scaleEffect(selectedIndex == index || selectedIndex == -1
                                         ? 1
                                         : 0.8
                            )
                            .rotation3DEffect(Angle(degrees: selectedIndex > -1 ? 360 : 0), axis: (x: 0, y: 1, z: 1))
                            .animation(index == selectedIndex
                                       ? .interpolatingSpring(stiffness: 30, damping: 10).repeatCount(2, autoreverses: true)
                                       : nil
                                , value: selectedIndex > -1 ? 360 : 0)
                            .disabled(selectedIndex > -1)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: retry)
        } message: {
            Text("\(scoreMessage)")
        }
        .alert("Game over", isPresented: $reset) {
            Button("Restart", action: restart)
        } message: {
            Text("\(scoreMessage)")
        }
    }
    
    func flagTapped(index: Int) {
        nbOfTry += 1
        
        if randomFlag == index {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)"
            
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[index])"
        }
        
        if nbOfTry == 8 {
            reset = true
        } else {
            showScore = true
        }
    }
    
    func retry() {
        countries.shuffle()
        randomFlag = Int.random(in: 0..<3)
        selectedIndex = -1
    }
    
    func restart() {
        selectedIndex = -1
        
        nbOfTry = 0
        score = 0
        retry()
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}
