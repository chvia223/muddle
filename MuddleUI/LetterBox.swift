//
//  LetterBox.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/17/22.
//

import SwiftUI

struct LetterBox: View {
    @State var boxColor: Color = .green
    @State var displayedLetter: String = ""
    
    init (letter: String, color: Color) {
        boxColor = color
        displayedLetter = letter
    }
    
    init () {

    }
    
    func setLetter (letter: String) {
        displayedLetter = letter
    }
    
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
        LetterBox(letter: "b", color: .red)
    }
}
