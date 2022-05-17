//
//  WordRow.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/17/22.
//

import SwiftUI

struct WordRow: View {
    var body: some View {
        HStack {
            LetterBox()
            LetterBox()
            LetterBox()
            LetterBox()
            LetterBox()
        }
    }
}

struct WordRow_Previews: PreviewProvider {
    static var previews: some View {
        WordRow()
    }
}
