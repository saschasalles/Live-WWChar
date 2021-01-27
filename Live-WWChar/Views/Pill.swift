//
//  Pill.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import SwiftUI

struct Pill: View {
    var text: String
    private var color: Color = Color.black
    
    init(text: String){
        self.text = text
        switch text {
        case "Gryffondor":
            self.color = Color(.systemRed)
        case "Serpentar":
            self.color = Color(.systemGreen)
        case "Pouffsoufle":
            self.color = Color(.systemYellow)
        case "Serdaigle":
            self.color = Color(.systemBlue)
        default:
            self.color = Color(.black)
        }
    }

    
    
    var body: some View {
        VStack {
            Text(self.text)
                .foregroundColor(.white)
                .font(.callout)
                .padding(6)
        }
        .background(self.color)
        .cornerRadius(10)
        
    }
}
