//
//  Course-Example.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import Foundation

extension Course {
    static var example: Course {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let course = Course(context: viewContext)
        course.color = Course.colors[0]
        course.detail = "This is an example course"
        course.icon = Course.icons[0]
        course.title = "Example Course"
//        course.addToTopics(Topic.example)
        
        return course
    }
}
