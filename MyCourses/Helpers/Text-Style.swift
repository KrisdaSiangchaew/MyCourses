//
//  Text-Style.swift
//  SwiftUI Concept Explore 1
//
//  Created by Kris Siangchaew on 19/11/2563 BE.
//

import SwiftUI

extension Text {
    enum TextStyle {
        case title, subtitle
    }
    
    func style(as style: TextStyle) -> Text {
        switch style {
        case .title:
            return self
                .font(.system(.headline, design: .rounded))
        case .subtitle:
            return self
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
        }
    }
}
