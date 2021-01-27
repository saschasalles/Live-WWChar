//
//  ContentView.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var charVM = CharacterViewModel()
    @StateObject var houseVM = HouseViewModel()
    
    //Read data
    @FetchRequest(entity: House.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var houses: FetchedResults<House>
    
    @FetchRequest(entity: Character.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Character.house?.name, ascending: true)])
    var chars: FetchedResults<Character>
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(chars) { char in
                        NavigationLink(
                            destination: EditView(),
                            label: {
                                ListItem(char: char)
                            })
                    }.onDelete(perform: { indexSet in
                        self.charVM.deleteChar(context: context, char: chars[indexSet.first!])
                    })
                }
            }
                .listStyle(InsetGroupedListStyle())
                .navigationBarItems(trailing:
                Button(action: { self.charVM.isAddPresented.toggle() }) {
                    Image(systemName: "plus")
                        .font(.title)
            }
            )
            .sheet(isPresented: self.$charVM.isAddPresented) {
                AddView(charVM: charVM)
            }
            .navigationBarTitle("Wizarding World")
        }.onAppear(perform: {
            if self.houses.count < 4 {
                self.houseVM.addDefaultHouses(context: context)
            }
        })
        
    }

}


