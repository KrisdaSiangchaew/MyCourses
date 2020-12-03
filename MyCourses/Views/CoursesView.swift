//
//  CoursesView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 2/12/2563 BE.
//

import SwiftUI

struct CoursesView: View {
    let courses: FetchRequest<Course>
    
    let archived: Bool
    
    static let tagArchived = "Archived"
    static let tagOpen = "Open"
    
    init(showArchive: Bool) {
        self.archived = showArchive
        
        courses = FetchRequest<Course>(
            entity: Course.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Course.title, ascending: true)],
            predicate: NSPredicate(format: "archived = %d", archived)
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses.wrappedValue) { course in
                    Text(course.courseTitle)
                }
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        CoursesView(showArchive: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
