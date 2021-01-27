//
//  EditView.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import SwiftUI

struct EditView: View {
    var char: Character
    @ObservedObject var charVM: CharacterViewModel
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentation
    @FetchRequest(entity: House.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var houses: FetchedResults<House>

    // MARK: plage d'age autorisee
    let range = 1...665

    func verify() -> Bool {
        let result = (!self.charVM.firstName.isEmpty && !self.charVM.lastName.isEmpty == true) ? true : false
        return result
    }

    var body: some View {

        Form {
            Section(header: Text("Prénom")) {
                TextField("\(self.charVM.firstName)", text: self.$charVM.firstName)
            }
            Section(header: Text("Nom de famille")) {
                TextField("\(self.charVM.lastName)", text: self.$charVM.lastName)
            }
            Section(header: Text("Age actuel : \(self.charVM.age) ans")) {
                Stepper(value: self.$charVM.age,
                        in: range) {
                    Text("\(self.charVM.age) ans")
                }
            }

            Section(header: Text("Maison actuelle \(char.house?.name ?? "unknown")")) {
                Picker(selection: self.$charVM.houseSelection, label: Text("Choisir la maison")) {
                    ForEach(0 ..< houses.count) {
                        Text(houses[$0].name ?? "unknown")
                    }
                }
            }

            Button(action: {
                self.charVM.updateChar(context: context)
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Modifier le personnage")
                    .frame(maxWidth: .infinity, alignment: .center)
            }.disabled(!self.verify())


        }.navigationBarTitle(Text("Editer"))
            .onAppear(perform: {
            DispatchQueue.main.async {
                self.charVM.setUpdate(char: char)
            }
        }
        )

    }
}

