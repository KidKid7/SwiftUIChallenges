//
//  ViewsAndModifiers.swift
//  Challenges
//
//  Created by Kid Kid on 1/21/23.
//

import SwiftUI

struct CustomContainer<Content: View> : View {
    let row: Int
    let col: Int
    
    // @ViewBuilder: use tupleView to wrap multipe views in Content
    // let content: (Int, Int) -> Content: defines a closure that must be able to accept two integers and return some sort of content
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<row, id: \.self) { r in
                HStack {
                    ForEach(0..<col, id: \.self) { c in
                        content(r, c)
                    }
                }
            }
        }
    }
}

struct WaterMark: ViewModifier {
    let text: String
    
    // Custom Modifier can create and return
    // any view and as many as we want, regardless
    // the type of content is sent.
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .fontWeight(.light)
                .background(.black)
                .foregroundColor(.white)
                .padding(5)
        }
    }
}

extension View {
    func watterMarked(text: String) -> some View {
        return modifier(WaterMark(text: text))
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 100)
            .padding(20)
            .font(.caption)
            .foregroundColor(.white)
            .background(.purple)
            .clipShape(Circle())
    }
}

extension View {
    func titleStyle() -> some View {
        return modifier(TitleModifier())
    }
}

struct CapsuleText: View {
    let text: String
    var body: some View {
        Text(text)
            .padding(30)
            .multilineTextAlignment(.center)
            .background(.red)
            .clipShape(Capsule())
    }
}

struct ViewsAndModifiers: View {
    
    // builderView is called View composition,
    // refers to combining smaller views into bigger ones
    @ViewBuilder var builderView: some View {
        CapsuleText(text: "Custom View")
            .foregroundColor(.black)
        CapsuleText(text: "View Composition")
            .foregroundColor(.white)
            .padding(60)
            .background(.indigo)
            .clipShape(Rectangle())
            .watterMarked(text: "WaterMark")
    }
    
    var body: some View {
        List {
            VStack {
                builderView
                HStack(spacing: 0) {
                    Text("Custom")
                        .modifier(TitleModifier())
                    Text("Modifier")
                        .titleStyle()
                }
                
                CustomContainer(row: 3, col: 3) { r, c in
                    VStack {
                        Text("Cell")
                        Text("\(r)\(c)")
                    }
                    .titleStyle()
                }
                // foregroundColor: environment modifiers
                // Local modifiers always override environment modifiers from the parent.
                .foregroundColor(.yellow)
                .padding(40)
                .watterMarked(text: "custom view")
                .background(.black)
            }
        }
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}
