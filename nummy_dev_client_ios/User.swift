//
//  User.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-08-23.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var status: String
    @NSManaged var username: String
    @NSManaged var id: String
    @NSManaged var message: String
    @NSManaged var token: String
    
    func updateUser(dictionary: NSDictionary) {
        self.status = dictionary.valueForKey("status") as! String
        self.message = dictionary.valueForKey("message") as! String
        if (dictionary.valueForKey("data") != nil) {
            self.id = dictionary.valueForKey("data")?.valueForKey("id") as! String
            self.username = dictionary.valueForKey("data")?.valueForKey("username") as! String
            self.token = dictionary.valueForKey("data")?.valueForKey("token") as! String
        }
    }
}