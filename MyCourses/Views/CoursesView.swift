//
//  CoursesView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 2/12/2563 BE.
//

import SwiftUI

struct CoursesView: View {
    let showArchived: Bool
    let courses: FetchRequest<Course>
    
    static let tagArchived: String? = "Archived"
    static let tagOpen: String? = "Open"
    
    init(showArchive: Bool) {
        self.showArchived = showArchive
        
        courses = FetchRequest<Course>(
            entity: Course.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Course.creationDate, ascending: false)],
            predicate: NSPredicate(format: "archived = %d", showArchived)
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses.wrappedValue) { course in
                    Section(header: CourseHeaderView(course: course)) {
                        ForEach(course.courseTopics) { item in
                            TopicRowView(topic: item)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text(showArchived ? "Archived Courses" : "Open Courses"))
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        CoursesView(showArchive: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
