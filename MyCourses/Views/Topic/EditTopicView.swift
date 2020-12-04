//
//  EditTopicView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 4/12/2563 BE.
//

import SwiftUI

struct EditTopicView: View {
    @EnvironmentObject var dataController: DataController
    
    let topic: Topic
    
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    
    init(topic: Topic) {
        self.topic = topic
        
        _title = State(wrappedValue: topic.topicTitle)
        _detail = State(wrappedValue: topic.topicDetail)
        _priority = State(wrappedValue: Int(topic.priority))
        _completed = State(wrappedValue: topic.completed)
    }
    
    func update() {
        topic.course?.objectWillChange.send()
        
        topic.title = title
        topic.detail = detail
        topic.priority = Int16(priority)
        topic.completed = completed
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("", text: $title.onChange(update))
                TextField("", text: $detail.onChange(update))
            }
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Mark completed")) {
                Toggle("Completed", isOn: $completed.onChange(update))
            }
        }
        .navigationTitle("Edit Topic")
        .onDisappear(perform: dataController.save)
    }
}

struct EditTopicView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        NavigationView {
            EditTopicView(topic: Topic.example)
                .environmentObject(dataController)
        }
    }
}
