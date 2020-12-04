//
//  EditCourseView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 3/12/2563 BE.
//

import SwiftUI

struct EditCourseView: View {
    @EnvironmentObject var dataController: DataController
    
    let course: Course
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var archived: Bool
    
    let cols: [GridItem] = [
        GridItem(.adaptive(minimum: 44, maximum: 50))
    ]
    
    init(course: Course) {
        self.course = course
        
        _title = State(wrappedValue: course.courseTitle)
        _detail = State(wrappedValue: course.courseDetail)
        _color = State(wrappedValue: course.courseColor)
        _archived = State(wrappedValue: course.archived)
    }
    
    func update() {
        course.title = title
        course.detail = detail
        course.color = color
        course.archived = archived
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Enter title", text: $title)
                TextField("Enter detail", text: $detail)
            }
            Section(header: Text("Custom course color")) {
                LazyVGrid(columns: cols, content: {
                    ForEach(Course.colors, id: \.self) { item in
                        Color(item)
                            .frame(height: 44)
                            .overlay(Image(systemName: "checkmark.circle")
                                        .foregroundColor(color == item ? .white : .clear)
                                        .imageScale(.large)
                            )
                            .onTapGesture {
                                color = item
                            }
                    }
                })
            }
            Section {
                Button(course.archived ? "Unarchive this course" : "Archive this course") {
                    course.archived.toggle()
                    update()
                }
                Button("Delete this course") {
                    
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle(Text("Edit Course"))
        .onDisappear {
            update()
            try? dataController.container.viewContext.save()
        }
    }
}

struct EditCourseView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        EditCourseView(course: Course.example)
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
