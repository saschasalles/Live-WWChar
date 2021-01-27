//
//  CharacterViewModel.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import Foundation
import CoreData

class CharacterViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var age: Int = 0
    @Published var isAddPresented: Bool = false
    @Published var houseSelection: Int = 0
    
    
    func addChar(context: NSManagedObjectContext) -> Void {
        // requête pour recuperer les houses
        let req = NSFetchRequest<House>(entityName: "House")
        req.sortDescriptors = [NSSortDescriptor(keyPath: \House.name?, ascending: true)]
        
        // fait mon personnage
        let newChar = Character(context: context)
        newChar.firstName = self.firstName
        newChar.lastName = self.lastName
        newChar.age = Int64(self.age)
        newChar.id = UUID()
        
        do {
            // je recupere toute les maisons
            let fetchedHouses = try context.fetch(req)
            
            // je recupere la maison avec l'index que j'ai selectionné
            let charHouse = fetchedHouses[houseSelection]
            
            // j'ajoute le personnage dans la maison
            charHouse.addToCharacters(newChar)
            
            // je sauvegarde mon personnage
            try context.save()
            self.resetValues()
            //ferme la AddView
            self.isAddPresented.toggle()

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func resetValues() -> Void {
        self.firstName = ""
        self.lastName = ""
        self.age = 0
        self.houseSelection = 0
    }
    
    
}
