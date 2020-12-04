//
//  DataController-CreateSampleData.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import Foundation

extension DataController {
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        (1...5).forEach { i in
            let course = Course(context: viewContext)
            course.archived = Bool.random()
            course.color = Course.colors[Int.random(in: 0..<Course.colors.count)]
            course.creationDate = Date.randomDateWithin(numberOfDays: 30)
            course.detail = "This is detail of Course \(i)."
            course.title = "Course \(i)"
            (1...5).forEach { j in
                let topic = Topic(context: viewContext)
                topic.completed = Bool.random()
                topic.creationDate = Date()
                topic.detail = "This is description for this topic."
                topic.priority = Int16.random(in: 0...3)
                topic.title = "Topic \(j)"

                topic.course = course
            }
        }
        
        try viewContext.save()
    }
    
    static var preview: DataController = {
        let controller = DataController(inMemory: true)
        
        do {
            try controller.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return controller
    }()
}
