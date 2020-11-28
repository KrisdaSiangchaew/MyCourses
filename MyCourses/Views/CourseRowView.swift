//
//  CourseRowView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 23/11/2563 BE.
//

import SwiftUI

struct CourseRowView: View {
    @ObservedObject var course: Course
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(course.courseTitle)
                    
                ProgressView(value: course.completionAmount)
                    .accentColor(Color(course.courseColor))
            }
            NavigationLink(
                destination: CourseEditView(course: course),
                label: { Image(systemName: "square.and.pencil")}
            )
        }
    }
}

struct CourseRowView_Previews: PreviewProvider {
    static var previews: some View {
        CourseRowView(course: Course.example)
    }
}
