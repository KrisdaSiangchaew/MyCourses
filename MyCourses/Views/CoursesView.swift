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
    
    static let tag: String? = "CourseList"
    
    @State private var showArchivedList: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Active Courses")) {
                    FilteredCourseList(isArchived: false) { course in
                        CourseRowView(course: course)
                    }
                }
                Section(header:
                    HStack {
                        Text("Archived Courses")
                        Spacer()
                        Toggle(isOn: $showArchivedList.animation(), label: {
                            Text("Show")
                        })
                    }
                )
                {
                    if showArchivedList {
                        FilteredCourseList(isArchived: true) { course in
                            CourseRowView(course: course)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        Group {
            CoursesView()
            CoursesView()
                .preferredColorScheme(.dark)
        }
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
}
