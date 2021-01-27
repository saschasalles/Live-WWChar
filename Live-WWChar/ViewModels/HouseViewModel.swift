//
//  HouseViewModel.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//

import Foundation
import CoreData

class HouseViewModel: ObservableObject {
    @Published var name: String = ""
    
    func addDefaultHouses(context: NSManagedObjectContext) -> Void {
        let gryffondor = House(context: context)
        gryffondor.name = "Gryffondor"
        gryffondor.id = UUID()
        let serpentar = House(context: context)
        serpentar.name = "Serpentar"
        serpentar.id = UUID()
        let serdaigle = House(context: context)
        serdaigle.name = "Serdaigle"
        serdaigle.id = UUID()
        let pouffsoufle = House(context: context)
        pouffsoufle.name = "Pouffsoufle"
        pouffsoufle.id = UUID()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

