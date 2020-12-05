//
//  DataController-HasEarned.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 5/12/2563 BE.
//

import Foundation
import CoreData

extension DataController {
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "topics":
            let request: NSFetchRequest<Topic> = NSFetchRequest<Topic>(entityName: "Topic")
            let awardCount = count(for: request)
            return awardCount >= award.value
        case "complete":
            let request: NSFetchRequest<Topic> = NSFetchRequest<Topic>(entityName: "Topic")
            request.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: request)
            return awardCount >= award.value
        default:
            return false
        }
    }
}
