//
//  FlagModifier.swift
//  Challenges
//
//  Created by Kid Kid on 1/22/23.
//

import SwiftUI

struct FlagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(color: .black, radius: 5)
    }
}

extension View {
    func flagged(name: String) -> some View {
        modifier(FlagModifier())
    }
}
