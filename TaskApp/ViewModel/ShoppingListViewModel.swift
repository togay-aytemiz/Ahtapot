//
//  ShoppingListViewModel.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 28.04.2021.
//

import SwiftUI
import CoreData
import UIKit
import Combine

class ShoppingList: ObservableObject {
    
    @Environment(\.managedObjectContext) var context
    
    @Published var content = ""
    @Published var date = Date()
    @Published var completion: Bool = false
    
    
    // Create item
    func firstTimeAddItem(context: NSManagedObjectContext){
        
        
        let newItem = Shopping(context: context)
        newItem.date = date
        newItem.content = content
        newItem.completion = false
        
        
        // saving data
        do{
            try context.save()
            content = ""
            date = Date()
            completion = false
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
