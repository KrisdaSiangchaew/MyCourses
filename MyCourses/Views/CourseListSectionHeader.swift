//
//  CourseListSectionHeader.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 23/11/2563 BE.
//

import SwiftUI

struct CourseListSectionHeader: View {
    let message: String
    @Binding var showList: Bool
    
    var body: some View {
        HStack {
            Text(message)
            Spacer()
            Toggle(isOn: $showList.animation()) {
                Image(systemName: showList ? "eye" : "eye.slash.fill")
            }
        }
    }
}

struct CourseListSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        CourseListSectionHeader(message: "Active", showList: .constant(true))
    }
}
