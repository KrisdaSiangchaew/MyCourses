//
//  CourseHeaderView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 3/12/2563 BE.
//

import SwiftUI

struct CourseHeaderView: View {
    @ObservedObject var course: Course
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(course.courseTitle)
                ProgressView("", value: course.completionAmount)
                    .accentColor(Color(course.courseColor))
            }
            Spacer()
            NavigationLink(destination: EditCourseView(course: course)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
        .padding(.bottom)
    }
}

struct CourseHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CourseHeaderView(course: Course.example)
    }
}
