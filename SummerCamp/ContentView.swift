//
//  ContentView.swift
//  SummerCamp
//
//  Created by Jason Ji on 6/8/24.
//

import SwiftUI

@Observable
class ViewModel {
    init() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted({
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd"
            return f
        }())
        
        _ = ActivitiesParser().parse(from: activities)
    }
}

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Swim clothes")
                } header: {
                    Text("Pack List")
                        .sectionHeaderStyle()
                }
                
                
                Section {
                    Text("Swimming Field Trip")
                    Text("Ninja Beam Challenge")
                } header: {
                    Text("Activities")
                        .sectionHeaderStyle()
                }
            }
            .navigationTitle("Monday, June 17")
        }
    }
}

#Preview {
    ContentView()
}

public extension View {
    func sectionHeaderStyle() -> some View {
        self
            .textCase(nil)
            .headerProminence(.increased)
            .padding([.leading, .trailing], -18)
    }
}
