//
//  CinemaApp.swift
//  Cinema
//
//  Created by José Rodriguez Romero on 06/03/24.
//

import SwiftUI

@main
struct CinemaApp: App {
    @State var isShowingSplashScreen = true // Añade esta línea
    
    var body: some Scene {
        WindowGroup {
            if isShowingSplashScreen {
                SplashScreenView(isShowingSplashScreen: $isShowingSplashScreen)
            } else {
                ContentView()
            }
        }
    }
}
