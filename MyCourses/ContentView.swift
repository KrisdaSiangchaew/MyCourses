//
//  ContentView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?
    
    var body: some View {
        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { Image(systemName: "house") }
                    )
                }
            CoursesView(forArchived: false)
                .tag(CoursesView.tagCurrent)
                .tabItem {
                    Label(
                        title: { Text("Current") },
                        icon: { Image(systemName: "books.vertical") }
                    )
                }
            CoursesView(forArchived: true)
                .tag(CoursesView.tagCurrent)
                .tabItem {
                    Label(
                        title: { Text("Archived") },
                        icon: { Image(systemName: "archivebox") }
                    )
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        
    }
}
