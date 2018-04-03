//
//  Item.swift
//  Todoey
//
//  Created by Aung Mon Chit Htwe on 1/4/18.
//  Copyright © 2018 AMCH. All rights reserved.
//

import Foundation

class Item : Codable{ // Codable = Encodable, Decodable
    var title : String = ""
    var done : Bool = false
}
