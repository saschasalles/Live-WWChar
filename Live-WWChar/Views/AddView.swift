//
//  AddView.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var charVM: CharacterViewModel
    @Environment(\.managedObjectContext) var context
    let range = 1...665 // MARK : plage d'age autorisee
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Prénom")) {
                    TextField("John", text: self.$charVM.firstName)
                }
                Section(header: Text("Nom de famille")) {
                    TextField("Appleseed", text: self.$charVM.lastName)
                }
                Section(header: Text("Age")) {
                    Stepper(value: self.$charVM.age,
                            in: range) {
                        Text("Actuel : \(self.charVM.age)")
                    }
                }
//                Section(header: Text("Maison")) {
//                    Picker(selection: $selectedHouse, label: Text("Choisir la maison")) {
//                        ForEach(0 ..< houses.count) {
//                            Text(houses[$0].name)
//                        }
//                    }
//                }

                Button(action: {
                    print("toto")
                }) {
                    Text("Ajouter le personnage")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarTitle("Ajouter")
        }
    }
}

