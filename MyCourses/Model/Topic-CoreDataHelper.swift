//
//  Topic-CoreDataHelper.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import Foundation

extension Topic {
    enum SortOrder {
        case optimized, index, dueDate
    }
    
    var topicDetail: String {
        detail ?? ""
    }
    
    var topicDueDate: Date {
        dueDate ?? Date()
    }
    
    var topicTitle: String {
        title ?? "New Topic"
    }
}
