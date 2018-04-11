//
//  Category.swift
//  Todoey
//
//  Created by Aung Mon Chit Htwe on 10/4/18.
//  Copyright © 2018 AMCH. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
