//
//  UserVO.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-06-24.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import Foundation
import UIKit

struct UserVO {
    var status: String = "blank"
    var message: String = ""
    var id: String = ""
    var username: String = ""
    var token: String = ""
    
    init(dictionary: NSDictionary) {
        self.status = dictionary.valueForKey("status") as! String
        self.message = dictionary.valueForKey("message") as! String
        if (dictionary.valueForKey("data") != nil) {
            self.id = dictionary.valueForKey("data")?.valueForKey("id") as! String
            self.username = dictionary.valueForKey("data")?.valueForKey("username") as! String
            self.token = dictionary.valueForKey("data")?.valueForKey("token") as! String
        }
    }
    
    mutating func setUser(newUser: UserVO) {
        self.status = newUser.status
        self.message = newUser.message
        self.id = newUser.id
        self.username = newUser.username
        self.token = newUser.token
    }
    
    mutating func resetUser() {
        self.status = "blank"
        self.message = ""
        self.id = ""
        self.username = ""
        self.token = ""
    }
    
    mutating func setId(newId: String) {
        self.id = newId
    }
    
    mutating func setUsername(newUsername: String) {
        self.username = newUsername
    }
    
    mutating func setStatus(newStatus: String) {
        self.status = newStatus
    }
    
    func getStatus() -> String {
        return self.status
    }
    
    func getMessage() -> String {
        return self.message
    }
}