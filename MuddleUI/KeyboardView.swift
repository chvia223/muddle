//
//  KeyboardView.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/23/22.
//

import SwiftUI

let row1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
let row2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
let row3 = [EnterString, "Z", "X", "C", "V", "B", "N", "M", DeleteString]

let EnterString = "ENT"
let DeleteString = "DEL"

enum KeyboardKey {
    case enter
    case delete
    case letter(String)
}



struct KeyboardView: View {
    let onKeyPressed: (KeyboardKey) -> Void
    
    func keyPressed(_ content: String) {
        switch (content) {
        case EnterString:
            onKeyPressed(.enter)
        case DeleteString:
            onKeyPressed(.delete)
        default:
            onKeyPressed(.letter(content))
        }
    }
    
    
    
    // Designed to find the correct sizing of each key using the available
    // geometry of the device.
    func keySize(_ keyboardWidth: CGFloat, content: String = "") -> CGFloat {
        let baseKeyWidth = (keyboardWidth - (CGFloat((row1.count - 1) * 10))) / CGFloat(row1.count)
        
        if (content == EnterString || content == DeleteString) {
            return (keyboardWidth - 80.0 - (baseKeyWidth * 7)) / 2
            
        } else {
            
            return baseKeyWidth
        }
    }
    

    
    var body: some View {
        GeometryReader { keyboardBox in
            VStack {
                HStack {
                    ForEach(row1.indices, id: \.self) { i in
                        KeyView(content: row1[i]) { content in
                            keyPressed(content)
                        }
                        .frame(width: keySize(keyboardBox.size.width))
                    }
                }
                
                HStack {
                    ForEach(row2.indices, id: \.self) { i in
                        KeyView(content: row2[i]) { content in
                            keyPressed(content)
                        }
                        .frame(width: keySize(keyboardBox.size.width))
                    }
                }
                
                HStack {
                    ForEach(row3.indices, id: \.self) { i in
                        KeyView(content: row3[i]) { content in
                            keyPressed(content)
                        }
                        .frame(width: keySize(keyboardBox.size.width, content: row3[i]))
                    }
                }
            }
            .frame(width: keyboardBox.size.width)
        }
    }
}

// View for individual key
struct KeyView: View {
    let content: String
    let action: (String) -> ()
    
    var body: some View {
        Button(action: {
            action(content)
            
        }, label: {
            if (content == EnterString || content == DeleteString) {
                Rectangle()
                    .overlay {
                        Text(content)
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .minimumScaleFactor(0.01)
                    }
                    .foregroundColor(.gray)
                    .cornerRadius(5)
                    .padding(-1)
                
            } else {
                Rectangle()
                    .overlay {
                        Text(content)
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .minimumScaleFactor(0.01)
                    }
                    .foregroundColor(.gray)
                    .cornerRadius(5)
                    .padding(-1)
            }
        })
    }
}


struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView() { _ in }
    }
}
