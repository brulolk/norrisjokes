//
//  Service.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 25/09/20.
//

import Foundation
import Alamofire

struct DataService {
    
    static let shared = DataService()
    
    func searchFacts(search: String, onComplete: @escaping ([Fact], String?) -> Void) {
        AF.request("\(URL_QUERY)\(search.replacingOccurrences(of: " ", with: "+"))").responseJSON { (response) in
            do {
                var facts: [Fact] = []
                let json = try response.result.get() as? NSDictionary
                if let resultArray: [[String: Any]] = json!["result"] as? [[String: Any]] {
                    for item in resultArray {
                        let fact = Fact(dictionary: item as Dictionary<String, AnyObject>)
                        facts.append(fact)
                    }
                    onComplete(facts, nil)
                } else {
                    onComplete([], "Nothing found with this term")
                }
            } catch {
                onComplete([], error.localizedDescription)
            }
        }
    }
    
    func searchForCategory(category: String, onComplete: @escaping (Fact?, String?) -> Void) {
        AF.request("\(URL_CATEGORY)\(category)").responseJSON { (response) in
            do {
                let json = try response.result.get() as? NSDictionary
                if let result: [String: Any] = json! as? [String: Any] {
                    let fact = Fact(dictionary: result as Dictionary<String, AnyObject>)
                    onComplete(fact, nil)
                } else {
                    onComplete(nil, "Nothing found with this term")
                }
            } catch {
                onComplete(nil, error.localizedDescription)
            }
        }
    }
    
    func searchCategories(onComplete: @escaping ([String], String?) -> Void) {
        AF.request("\(URL_BASE)/categories").responseJSON { (response) in
            do {
                let result = try response.result.get()
                if let categories = result as? [String] {
                    onComplete(categories, nil)
                } else {
                    onComplete([], "Nothing found categories")
                }
            } catch {
                onComplete([], error.localizedDescription)
            }
        }
    }
}

