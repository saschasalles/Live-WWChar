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
    
}
