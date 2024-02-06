//
//  Contact.swift
//  TechnicalTest-Form
//
//  Created by Xcaret Mora on 04/02/24.
//

import CoreData

@objc(Contact)
class Contact: NSManagedObject {
    
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var firtsName: String!
    @NSManaged var lastName: String!
    @NSManaged var mobileNumber: String!
    @NSManaged var email: String!

}
