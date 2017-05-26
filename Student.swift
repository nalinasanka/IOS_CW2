//
//  Student.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/20/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit
import os.log

class Student: NSObject
{
    var name: String
    var photo: UIImage?
    
    init?(studentName:String, studentPhoto:UIImage?) {
        
        if studentName.isEmpty {
            return nil
        }
        
        self.name = studentName
        self.photo = studentPhoto
        
    }
}

