//
//  TopicRowView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 4/12/2563 BE.
//

import SwiftUI

struct TopicRowView: View {
    @ObservedObject var topic: Topic
    
    var body: some View {
        NavigationLink(destination: EditTopicView(topic: topic)) {
            Text(topic.topicTitle)
        }
    }
}

struct TopicRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicRowView(topic: Topic.example)
    }
}
