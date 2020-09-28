//
//  Facts.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 25/09/20.
//

import UIKit

struct Fact: Codable {
    
    let id: String
    let categories: [String]
    let url: String
    let value: String
    
    init() {
        self.id = ""
        self.categories = []
        self.url = ""
        self.value = ""
    }
    
    init(id: String, categories: [String], url: String, value: String) {
        self.id = id
        self.categories = categories
        self.url = url
        self.value = value
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        let id = dictionary["id"] as? String
        let categories = dictionary["categories"] as? [String]
        let url = dictionary["url"] as? String
        let value = dictionary["value"] as? String
        
        self.init(id: id!, categories: categories!, url: url!, value: value!)
    }
}
