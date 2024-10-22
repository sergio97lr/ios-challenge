//
//  AppDelegate.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteEntity")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error al cargar el contenedor: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar el contexto: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Bundle.swizzleLocalization()
        Bundle.setLanguage(LocalizationManager.shared.getLanguage())
        
        let splashtRouter = SplashRouter()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashtRouter.view
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.async {
            self.applyStoredSettings()
        }
        
        return true
    }
    
    func applyStoredSettings() {
        let selectedTheme = UserDefaults.standard.string(forKey: "selectedTheme") ?? "system"
        applyTheme(selectedTheme)
    }
    
    func applyTheme(_ selectedTheme: String) {
        let interfaceStyle: UIUserInterfaceStyle
        switch selectedTheme {
        case "light":
            interfaceStyle = .light
        case "dark":
            interfaceStyle = .dark
        default:
            interfaceStyle = .unspecified
        }
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                for window in windowScene.windows {
                    window.overrideUserInterfaceStyle = interfaceStyle
                }
            }
        }
    }
}

