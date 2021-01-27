//
//  ListItem.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import SwiftUI

struct ListItem: View {
    @ObservedObject var char: Character
    var placeholder: String = "unknown"
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(self.char.firstName ?? self.placeholder) \(self.char.lastName ?? self.placeholder)")
                    .bold()
                Text("\(self.char.age) ans")
            }
            Spacer()
            Pill(text: self.char.house?.name ?? placeholder)
        }
        .padding(.vertical, 10)
    }
}
