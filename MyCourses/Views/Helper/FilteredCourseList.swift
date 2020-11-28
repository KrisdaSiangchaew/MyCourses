//
//  FilteredCourseList.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 23/11/2563 BE.
//

import SwiftUI

struct FilteredCourseList<Content: View>: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    let fetchRequest: FetchRequest<Course>
    let content: (Course) -> Content
    
    var courses: FetchedResults<Course> {
        fetchRequest.wrappedValue
    }
    
    init(isArchived: Bool, @ViewBuilder content: @escaping (Course) -> Content) {
        fetchRequest = FetchRequest<Course>(
                entity: Course.entity(),
                sortDescriptors: [
                    NSSortDescriptor(keyPath: \Course.title, ascending: true)
                ],
                predicate: NSPredicate(format: "archived == %d", isArchived)
            )
        
        self.content = content
    }
    
    var body: some View {
        ForEach(courses, id: \.self) { course in
            content(course)
        }
    }
}

struct FilteredCourseList_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        FilteredCourseList(isArchived: false) { course in
            CourseRowView(course: course)
        }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
