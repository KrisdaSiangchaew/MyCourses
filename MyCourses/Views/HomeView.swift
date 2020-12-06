//
//  HomeView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest<Course>(entity: Course.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Course.title, ascending: true)], predicate: NSPredicate(format: "archived = false")) var courses: FetchedResults<Course>
    
    let topics: FetchRequest<Topic>
    
    static let tag: String? = "Home"
    
    var projectRows: [GridItem] = [
        GridItem(.fixed(100))
    ]
    
    init() {
        let request: NSFetchRequest<Topic> = Topic.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Topic.priority, ascending: true)]
        request.predicate = NSPredicate(format: "completed = false")
        request.fetchLimit = 10
        
        topics = FetchRequest(fetchRequest: request)
    }
    
    @ViewBuilder func list(_ title: String, for topics: FetchedResults<Topic>.SubSequence) -> some View {
        if topics.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            ForEach(topics) { topic in
                NavigationLink(destination: EditTopicView(topic: topic)) {
                    HStack(spacing: 20) {
                        Circle()
                            .stroke(Color(topic.course?.courseColor ?? "Light Blue"), lineWidth: 3)
                            .frame(width: 44, height: 44)
                        VStack(alignment: .leading) {
                            Text(topic.topicTitle)
                                .font(.title2)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if !topic.topicDetail.isEmpty {
                                Text(topic.topicDetail)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.secondarySystemGroupedColor)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: projectRows) {
                            ForEach(courses) { course in
                                VStack(alignment: .leading) {
                                    Text("\(course.courseTopics.count) topics")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(course.courseTitle)
                                        .font(.title2)
                                    ProgressView(value: course.completionAmount)
                                        .accentColor(Color(course.courseColor))
                                }
                                .padding()
                                .background(Color.secondarySystemGroupedColor)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 5)
                            }
                        }
                        .padding([.horizontal, .top])
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
                VStack(alignment: .leading) {
                    list("Up next", for: topics.wrappedValue.prefix(3))
                    list("More to explore", for: topics.wrappedValue.dropFirst(3))
                }
                .padding(.horizontal)
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        HomeView()
            .environmentObject(dataController)
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
