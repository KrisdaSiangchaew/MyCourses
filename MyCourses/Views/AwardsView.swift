//
//  AwardsView.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 5/12/2563 BE.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    
    let awards: [Award]
    
    @State private var selectedAward: Award = Award.example
    @State private var showAwardDetail = false
    
    static let tag: String? = "Awards"
    
    let cols: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: cols, alignment: .center) {
                    ForEach(awards) { award in
                        Button {
                            selectedAward = award
                            showAwardDetail = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(
                                    dataController.hasEarned(award: award) ? Color(award.color) :
                                    Color.secondary.opacity(0.5))
                        }
                    }
                    .navigationTitle("Awards")
                }
            }
        }
        .alert(isPresented: $showAwardDetail) {
            if dataController.hasEarned(award: selectedAward) {
                return Alert(title: Text("Unlocked: \(selectedAward.name)"), message: Text(selectedAward.description), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Locked"), message: Text(selectedAward.description), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static let dataController = DataController.preview
    
    static var previews: some View {
        AwardsView(awards: Award.allAwards)
            .environmentObject(dataController)
    }
}
