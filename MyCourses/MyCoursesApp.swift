//
//  MyCoursesApp.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 20/11/2563 BE.
//

import SwiftUI

@main
struct MyCoursesApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)
        }
    }
    
    func save(_ notification: Notification) {
        dataController.save()
    }
}
