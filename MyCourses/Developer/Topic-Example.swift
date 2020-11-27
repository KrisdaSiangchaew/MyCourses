//
//  Topic-Example.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import Foundation

extension Topic {
    static var example: Topic {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        
        let topic = Topic(context: viewContext)
        topic.title = "New Topic"
        topic.detail = "This is an example topic."
        
        return topic
    }
    
}
