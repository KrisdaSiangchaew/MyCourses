//
//  EditCourseView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 3/12/2563 BE.
//

import SwiftUI

struct EditCourseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataController: DataController
    
    let course: Course
    
    @State private var showingDeleteConfirm = false
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var archived: Bool
    
    let cols: [GridItem] = [
        GridItem(.adaptive(minimum: 80, maximum: 80))
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
    
    func delete() {
        dataController.delete(course)
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Enter title", text: $title.onChange(update))
                TextField("Enter detail", text: $detail.onChange(update))
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
                                update()
                            }
                    }
                })
            }
            Section(footer: Text("Delete this course completely removes this course. Archive the course moves it to Archive view.")) {
                Button(course.archived ? "Unarchive this course" : "Archive this course") {
                    archived.toggle()
                    update()
                }
                Button("Delete this course") {
                    showingDeleteConfirm.toggle()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle(Text("Edit Course"))
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Are you sure you want to delete \(course.courseTitle)?"), message: nil, primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
    }
}

struct EditCourseView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        EditCourseView(course: Course.example)
            .environmentObject(dataController)
    }
}
