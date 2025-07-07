//
//  ModernistYazilimCaseApp.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 3.07.2025.
//

import SwiftUI

@main
struct AppEntryPoint {
    static func main() {
        ModernistYazilimCaseApp.main()
    }
}


struct ModernistYazilimCaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .environmentObject(appDelegate.dependencies.container)
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    var dependencies: Dependencies!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.dependencies = Dependencies()
        return true
    }
}
