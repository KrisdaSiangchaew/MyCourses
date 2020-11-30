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
        Form {
            Section(header: Text("Basic settings")) {
                TextField(course.courseTitle, text: $title.onChange(update))
                TextField(course.courseDetail, text: $detail.onChange(update))
            }
            
            Section(header: Text("Custom course color")) {
                colorsPanel
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
    
    var colorsPanel: some View {
        let cols: [GridItem] = [
            GridItem(.adaptive(minimum: 44, maximum: 100), spacing: 8),
        ]
        return LazyVGrid(columns: cols) {
            ForEach(Course.colors, id: \.self) { color in
                Color(color)
                    .frame(height: 44)
                    .cornerRadius(5)
                    .overlay(
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(course.courseColor == color ? .white : .clear)
                    )
                    .onTapGesture {
                        self.color = color
                        update()
                    }
            }
        }
    }
}

struct CourseEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseEditView(course: Course.example)
        }
    }
}
