//
//  CoreDataManager.swift
//  TechnicalTest-Form
//
//  Created by Xcaret Mora on 06/02/24.
//

import CoreData
import UIKit

class CoreDataManager {
    
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                guard let note = result as? Contact else { return }
                contactList.append(note)
                print("Recuperacion exitosa")
            }
        }
        catch
        {
            print("Recuperacion fallida")
        }
    }
}
