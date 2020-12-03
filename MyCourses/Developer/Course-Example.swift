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
        course.detail = "This is an example course"
        course.title = "Example Course"
        course.archived = false
        course.color = Course.colors[0]
        
        try? viewContext.save()
        
        return course
    }
}
