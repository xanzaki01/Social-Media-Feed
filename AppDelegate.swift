//
//  AppDelegate.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 04/07/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let vc = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        setUpNavigationBar()
        return true
    }
    private func setUpNavigationBar() {
        let app = UINavigationBarAppearance()
        app.configureWithOpaqueBackground()
        app.backgroundColor = .systemBlue
        
        UINavigationBar.appearance().standardAppearance = app
        UINavigationBar.appearance().scrollEdgeAppearance = app
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Social_Media_Feed")
        container.loadPersistentStores{_, error in
            if let error = error as NSError? {
                fatalError("Core Data error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static var shared: AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}

