//
//  UserRequest+CoreDataClass.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/10/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserRequest)
public class UserRequest: NSManagedObject {
    convenience init() {
        // MARK: - Create a new object
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "UserRequest"),
                  insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
