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
    @Published var characterToEdit: Character!
    
    fileprivate let houseReq = NSFetchRequest<House>(entityName: "House")
    
    
    func addChar(context: NSManagedObjectContext) -> Void {
        // requête pour recuperer les houses
        self.houseReq.sortDescriptors = [NSSortDescriptor(keyPath: \House.name?, ascending: true)]
        
        // fait mon personnage
        let newChar = Character(context: context)
        newChar.firstName = self.firstName
        newChar.lastName = self.lastName
        newChar.age = Int64(self.age)
        newChar.id = UUID()
        
        do {
            // je recupere toute les maisons
            let fetchedHouses = try context.fetch(self.houseReq)
            
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
    
    func deleteChar(context: NSManagedObjectContext, char: NSManagedObject) -> Void {
        //je supprime l'object du context
        context.delete(char)
        do {
            // je sauvegarde l'etat du context
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setUpdate(char: Character) -> Void {
        self.characterToEdit = char
        self.firstName = char.firstName ?? "unknown"
        self.lastName = char.lastName ?? "unknown"
        self.age = Int(char.age)
        
    }
    
    func updateChar(context: NSManagedObjectContext) -> Void {
        let char = context.object(with: self.characterToEdit.objectID)
        char.setValue(self.firstName, forKey: "firstName")
        char.setValue(self.lastName, forKey: "lastName")
        char.setValue(Int64(self.age), forKey: "age")
        
        do {
            houseReq.sortDescriptors = [NSSortDescriptor(keyPath: \House.name?, ascending: true)]
            let fetchedHouses = try context.fetch(houseReq)
            let newHouse = fetchedHouses[houseSelection]
            char.setValue(newHouse, forKey: "house")
            
            try context.save()
            self.resetValues()
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
