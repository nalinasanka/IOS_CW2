//
//  Event.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/21/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit
import os.log

class Event: NSObject, NSCoding
{
    var name: String
    var place: String
    var photo: UIImage?
    //var venueDateTime: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let place = "place"
    }
    
    init?(eventName:String, eventPhoto:UIImage?, eventPlace:String) {
        
        if eventName.isEmpty {
            return nil
        }
        
        self.name = eventName
        self.place = eventPlace
        
        if eventPhoto == nil
        {
            let samplePhoto = UIImage(named: "TheaterIcon")
            self.photo = samplePhoto
        }
        else
        {
            self.photo = eventPhoto
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(place, forKey: PropertyKey.place)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else {
                os_log("Unable to decode the name for a Contact object.", log: OSLog.default, type:.debug)
                return nil
        }
        
        guard let place = aDecoder.decodeObject(forKey: PropertyKey.place) as? String
            else {
                os_log("Unable to decode the plce for a Contact object.", log: OSLog.default, type: .debug)
                return nil
        }
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        self.init(eventName: name, eventPhoto: photo, eventPlace:place)
    }
    
}
