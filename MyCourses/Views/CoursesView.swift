//
//  CoursesView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import SwiftUI

struct CoursesView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    static let tagCurrent: String = "Current"
    static let tagArchived: String = "Archived"
    
    let archived: Bool
    
    let fetchRequest: FetchRequest<Course>
    
    var courses: FetchedResults<Course> {
        fetchRequest.wrappedValue
    }
    
    init(forArchived archived: Bool) {
        self.archived = archived
        
        fetchRequest = FetchRequest<Course>(
            entity: Course.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Course.title, ascending: true)],
            predicate: NSPredicate(format: "archived = %d", archived)
        )
    }
    
    @State private var showArchivedList: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses, id: \.self) { course in
                    Section(header: CourseRowView(course: course)) {
                        ForEach(course.courseTopics(using: .optimized), id: \.id) { topic in
                            TopicRowView(topic: topic)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(archived ? "Archived Courses" : "Current Courses")
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        Group {
            CoursesView(forArchived: true)
            CoursesView(forArchived: true)
                .preferredColorScheme(.dark)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
