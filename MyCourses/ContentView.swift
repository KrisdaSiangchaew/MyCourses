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
            
            CoursesView(showArchive: false)
                .tag(CoursesView.tagOpen)
                .tabItem {
                    Label(
                        title: { Text("Open") },
                        icon: { Image(systemName: "books.vertical") }
                    )
                }
            
            CoursesView(showArchive: true)
                .tag(CoursesView.tagArchived)
                .tabItem {
                    Label(
                        title: { Text("Archived") },
                        icon: { Image(systemName: "archivebox") }
                    )
                }
            
            AwardsView(awards: Award.allAwards)
                .tag(AwardsView.tag)
                .tabItem {
                    Label(
                        title: { Text("Awards") },
                        icon: { Image(systemName: "rosette") }
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
