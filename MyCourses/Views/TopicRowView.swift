//
//  TopicRowView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 23/11/2563 BE.
//

import SwiftUI

struct TopicRowView: View {
    @ObservedObject var topic: Topic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(topic.topicTitle)
                .style(as: .title)
            Text(topic.topicDetail)
            Text(dateString)
        }
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: topic.topicCreationDate)
    }
}

struct TopicRowView_Previews: PreviewProvider {
    static var previews: some View {
        TopicRowView(topic: Topic.example)
    }
}
