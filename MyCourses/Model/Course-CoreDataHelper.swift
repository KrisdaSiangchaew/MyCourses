//
//  Course-CoreDataHelper.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import Foundation

extension Course {
    
    var courseColor: String {
        color ?? Course.colors[0]
    }
    
    var courseDetail: String {
        detail ?? ""
    }
    
    var courseIcon: String {
        icon ?? Course.icons[0]
    }
    
    var courseTitle: String {
        title ?? "New Course"
    }
    
    var courseTopics: [Topic] {
        topics?.allObjects as? [Topic] ?? []
    }
    
    func courseTopics(using sortOrder: Topic.SortOrder) -> [Topic] {
        switch sortOrder {
        case .index:
            return courseTopics.sorted { $0.ordering < $1.ordering }
        case .dueDate:
            return courseTopics
                .sorted { $0.topicDueDate < $1.topicDueDate }
                .sorted { $0.ordering < $1.ordering }
        case .optimized:
            return courseTopicsDefaultSorted
        }
    }
    
    var courseTopicsDefaultSorted: [Topic] {
        return courseTopics.sorted {
            if $0.completed == false {
                if $1.completed == true {
                    return true
                }
            } else if $0.completed == true {
                if $1.completed == false {
                    return false
                }
            }
            
            return $0.ordering < $1.ordering
        }
    }
    
    var numberOfTopics: Int {
        let originalTopics = topics?.allObjects as? [Topic] ?? []
        guard originalTopics.isEmpty == false else { return 0 }
        
        return originalTopics.count
    }
    
    var completionAmount: Double {
        let originalTopics = topics?.allObjects as? [Topic] ?? []
        guard originalTopics.isEmpty == false else { return 0 }
        
        let completedTopics = originalTopics.filter(\.completed)
        
        return Double(completedTopics.count) / Double(originalTopics.count)
    }
    
    static let colors: [String] = [
        "Dark Blue", "Dark Gray", "Gold", "Gray", "Green", "Light Blue", "Midnight", "Orange", "Pink", "Purple", "Red", "Teal"
    ]
    
    static let icons: [String] = [
        "mic.circle.fill", "bubble.right.fill", "waveform.circle.fill"
    ]
}
