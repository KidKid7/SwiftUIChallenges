//
//  FlagImage.swift
//  Challenges
//
//  Created by Kid Kid on 1/22/23.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name.lowercased())
            .flagged(name: name)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "us")
    }
}
