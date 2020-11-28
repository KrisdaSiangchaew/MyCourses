//
//  CourseEditView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 28/11/2563 BE.
//

import SwiftUI

struct CourseEditView: View {
    @ObservedObject var course: Course
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    
    init(course: Course) {
        self.course = course
        
        _title = State(wrappedValue: course.courseTitle)
        _detail = State(wrappedValue: course.courseDetail)
        _color = State(wrappedValue: course.courseColor)
    }
    
    func update() {
        course.title = title
        course.detail = detail
        course.color = color
    }
    
    var body: some View {
        List {
            Section(header: Text("Basic settings")) {
                TextField(course.courseTitle, text: $title.onChange(update))
                TextField(course.courseDetail, text: $detail.onChange(update))
            }
            
            Section(header: Text("Custom course color")) {
                
            }
            
            Section {
                Button(action: { }, label: {
                    Text("Archive this course")
                })
                Button(action: { }, label: {
                    Text("Delete this course")
                        .accentColor(.red)
                })
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Edit Course"))
    }
}

struct CourseEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseEditView(course: Course.example)
        }
    }
}
