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
        
        (1...10).forEach { i in
            let course = Course(context: viewContext)
            course.archived = Bool.random()
            course.color = Course.colors[Int.random(in: 0..<Course.colors.count)]
            course.detail = "This is detail of Course \(i)."
            course.favorite = Bool.random()
            course.icon = Course.icons[Int.random(in: 0..<Course.icons.count)]
            course.title = "Course \(i)"
            (1...10).forEach { j in
                let topic = Topic(context: viewContext)
                topic.completed = Bool.random()
                topic.detail = "This is description for this topic."
                topic.dueDate = topic.completed ? nil : Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 86_400...2_592_000)))
                topic.ordering = Int16(j)
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
