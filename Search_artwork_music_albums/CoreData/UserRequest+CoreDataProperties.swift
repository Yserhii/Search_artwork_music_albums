//
//  UserRequest+CoreDataProperties.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/10/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//
//

import Foundation
import CoreData


extension UserRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRequest> {
        return NSFetchRequest<UserRequest>(entityName: "UserRequest")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var name: String?

}
