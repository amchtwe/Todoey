//
//  Item.swift
//  Todoey
//
//  Created by Aung Mon Chit Htwe on 10/4/18.
//  Copyright © 2018 AMCH. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date = Date()
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
