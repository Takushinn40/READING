//
//  HappyReadingApp.swift
//  HappyReading
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

@main
struct HappyReadingApp: App {
   @StateObject var viewModel: ViewModel = ViewModel()
    var body: some Scene{
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
