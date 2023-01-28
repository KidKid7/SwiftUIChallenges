//
//  Animation.swift
//  Challenges
//
//  Created by Kid Kid on 1/26/23.
//

import SwiftUI

struct CornerRotateModifer: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
 
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped() // within bounds
    }
}

fileprivate extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifer(amount: 90, anchor: .topLeading),
                  identity: CornerRotateModifer(amount: 0, anchor: .topLeading))
    }
    
    static var reversePivot: AnyTransition {
        .modifier(active: CornerRotateModifer(amount: 0, anchor: .topLeading),
                  identity: CornerRotateModifer(amount: 90, anchor: .topLeading))
    }
}

struct Animation: View {
    let letters = Array("Hello, SwifUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var showCard = false
    @State private var buttonDegree = 0.0
    @State private var showPivot = true
    
    var body: some View {
        VStack(spacing: 15) {
            
            ZStack {
                if showPivot {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 180, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .transition(.pivot)
                } else {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 180, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .transition(.reversePivot)
                }
           
                Text("Custom Transition")
                    .frame(width: 180, height: 60)
                    //.background(Color(uiColor: UIColor.lightGray))
                    .foregroundColor(showPivot ? .white : .black)
            }
            .onTapGesture {
                withAnimation {
                    showPivot.toggle()
                }
            }
            
            Button(!showCard ? "Show Card" : "Hide Card") {
                // Explicit animation
                //withAnimation {
                showCard.toggle()
                buttonDegree = buttonDegree == 360 ? 0 : 360
                //}
            }
            .foregroundColor(.white)
            .padding(20)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .rotation3DEffect(Angle(degrees: buttonDegree), axis: (x: 1, y: 1, z: 1))
            .animation(.interpolatingSpring(stiffness: 50, damping: 10), value: buttonDegree)
            .onAppear {
                buttonDegree = 360
            }
            
            if showCard {
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                // Explicit
                                withAnimation {
                                    dragAmount = CGSize.zero
                                }
                            }
                    )
                    // Asymmetric transitions let us specify one transition for insertion and another for removal.
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                // .transition(.scale) // scale up and down as it is shown
                // Implicit animation
                // .animation(.spring(), value: dragAmount)
            }
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(
                            .default.delay(Double(num) / Double(letters.count)),
                            value: dragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )
        }
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        Animation()
    }
}
