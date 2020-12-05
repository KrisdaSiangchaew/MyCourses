//
//  AwardsView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 5/12/2563 BE.
//

import SwiftUI

struct AwardsView: View {
    let awards: [Award]
    
    static let tag: String? = "Awards"
    
    let cols: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: cols, alignment: .center) {
                    ForEach(awards) { item in
                        Button {
                            
                        } label: {
                            Image(systemName: item.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.secondary.opacity(0.5))
                        }
                    }
                    .navigationTitle("Awards")
                }
            }
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView(awards: Award.allAwards)
    }
}
