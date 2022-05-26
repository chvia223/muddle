//
//  LetterBox.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/17/22.
//

import SwiftUI

struct LetterBox: View {
    let displayedLetter: String
    let boxColor: Color
    
    var body: some View {
        Rectangle()
            .overlay {
                Text(displayedLetter)
                    .foregroundColor(.white)
                    .font(.system(size: 300))
                    .minimumScaleFactor(0.01)
                
            }
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(boxColor)
    }
}

struct LetterBox_Previews: PreviewProvider {
    static var previews: some View {
        LetterBox(displayedLetter: "a", boxColor: .gray)
    }
}
