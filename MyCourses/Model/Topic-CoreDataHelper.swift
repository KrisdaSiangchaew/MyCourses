//
//  Topic-CoreDataHelper.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import Foundation

extension Topic {
    enum SortOrder: String {
        case optimized, creationDate, title
    }
    
    enum Priority: Int16 {
        case none = 0, low, medium, high
    }
    
    var topicCreationDate: Date {
        creationDate ?? Date()
    }
    
    var topicDetail: String {
        detail ?? ""
    }
    
    var topicTitle: String {
        title ?? "New Topic"
    }
}
