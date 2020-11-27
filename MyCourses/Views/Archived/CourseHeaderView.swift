//
//  CourseHeaderView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import SwiftUI

struct CourseHeaderView: View {
    @ObservedObject var course: Course
    
    var body: some View {
        HStack {
            Image(systemName: course.courseIcon)
                .style(as: .smallIcon, color: course.courseColor)
            
            VStack(alignment: .leading) {
                Text(course.courseTitle)
                    
                ProgressView(value: course.completionAmount)
                    .accentColor(Color(course.courseColor))
            }
            
            NavigationLink(
                destination: Text("\(course.courseTitle) details."),
                label: {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                })
        }
    }
}

struct CourseHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CourseHeaderView(course: Course.example)
    }
}
