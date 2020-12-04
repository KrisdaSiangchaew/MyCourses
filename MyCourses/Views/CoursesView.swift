//
//  CoursesView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 2/12/2563 BE.
//

import SwiftUI

struct CoursesView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var moc
    
    let showArchived: Bool
    let courses: FetchRequest<Course>
    
    static let tagArchived: String? = "Archived"
    static let tagOpen: String? = "Open"
    
    init(showArchive: Bool) {
        self.showArchived = showArchive
        
        courses = FetchRequest<Course>(
            entity: Course.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Course.creationDate, ascending: true)],
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
                        .onDelete { offsets in
                            let allItems = course.courseTopics
                            
                            for offset in offsets {
                                let topic = allItems[offset]
                                dataController.delete(topic)
                            }
                            dataController.save()
                        }
                        Button(action: {
                            let topic = Topic(context: moc)
                            topic.course = course
                            topic.creationDate = Date()
                            dataController.save()
                        }, label: {
                            Label(
                                title: { Text("Add new item") },
                                icon: { Image(systemName: "plus") }
)
                        })
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text(showArchived ? "Archived Courses" : "Open Courses"))
            .toolbar {
                if showArchived == false {
                    Button(action: {
                        withAnimation {
                            let course = Course(context: moc)
                            course.creationDate = Date()
                            course.archived = false
                            
                            dataController.save()
                        }
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
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
            .environmentObject(dataController)
    }
}
