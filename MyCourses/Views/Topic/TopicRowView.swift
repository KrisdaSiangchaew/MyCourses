//
//  TopicRowView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 4/12/2563 BE.
//

import SwiftUI

struct TopicRowView: View {
    @ObservedObject var course: Course
    @ObservedObject var topic: Topic
    
    var icon: some View {
        if topic.completed == true {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(Color(course.courseColor))
        } else if topic.priority == Topic.Priority.high.rawValue {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(course.courseColor))
        } else {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(.clear)
        }
    }
    
    var body: some View {
        NavigationLink(destination: EditTopicView(topic: topic)) {
            Label(
                title: { Text(topic.topicTitle) },
                icon: { icon }
            )
        }
    }
}

struct TopicRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicRowView(course: Course.example, topic: Topic.example)
    }
}
