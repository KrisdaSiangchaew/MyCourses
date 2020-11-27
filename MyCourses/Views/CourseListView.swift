//
//  CourseListView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 23/11/2563 BE.
//

import SwiftUI

struct CourseListView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dataController: DataController
    
    @State private var showActiveList: Bool = true
    @State private var showArchivedList: Bool = true
    
    var body: some View {
        List {
            Section(header: CourseListSectionHeader(message: "Active", showList: $showActiveList)) {
                if showActiveList {
                    FilteredCourseList(isArchived: false) { course in
                        CourseRowView(course: course)
                    }
                }
            }
            Section(header: CourseListSectionHeader(message: "Archived", showList: $showArchivedList)) {
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

struct CourseListView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        CourseListView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
