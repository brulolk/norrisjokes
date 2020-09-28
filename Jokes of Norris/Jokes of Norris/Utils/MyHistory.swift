//
//  MyHistory.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import Foundation

class MyHistory {
    
    private static let HISTORY_TERMS = "lastSearchs"
    private static let CATEGORIES = "categories"
    
    public static func setSearchTerm(term: String) {
        var lastTerms = getSearchTerms(inverted: false)
        for (index, item) in lastTerms.enumerated() {
            if "\(item)" == term {
                lastTerms.remove(at: index)
            }
        }
        if lastTerms.count == 5 {
            lastTerms.removeFirst()
        }
        lastTerms.append(term)
        UserDefaults.standard.setValue(lastTerms, forKey: HISTORY_TERMS)
    }
    
    public static func getSearchTerms(inverted: Bool) -> [Any] {
        let terms = UserDefaults.standard.array(forKey: HISTORY_TERMS)
        if terms != nil {
            if inverted {
                return terms!.reversed()
            } else {
                return terms!
            }
        } else {
            return []
        }
    }
    
    public static func setCategories(categorys: [String]) {
        UserDefaults.standard.setValue(categorys, forKey: CATEGORIES)
    }
    
    public static func getCategories() -> [Any] {
        let categories = UserDefaults.standard.array(forKey: CATEGORIES)!.shuffled()
        return categories
    }
}
