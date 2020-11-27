//
//  Image-Style.swift
//  SwiftUI Concept Explore 1
//
//  Created by Kris Siangchaew on 19/11/2563 BE.
//

import SwiftUI

extension Image {
    enum ImageStyle {
        case smallIcon
    }
    
    func style(as style: ImageStyle, color: String) -> some View {
        switch style {
        case .smallIcon:
            return self
                .imageScale(.large)
                .foregroundColor(Color(color))
        }
    }
}
