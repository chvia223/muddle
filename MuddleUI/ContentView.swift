//
//  ContentView.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/17/22.
//

import SwiftUI

struct Word {
    var Elements = [LetterBox]()
}

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                LetterBox(letter: "b", color: .red)
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
            }
            
            HStack {
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
            }
            
            HStack {
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
            }
            
            HStack {
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
            }
            
            HStack {
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
            }
            
            HStack {
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
                LetterBox()
            }
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
