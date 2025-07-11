//
//  CoreDataServices.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 09/07/25.
//

import UIKit
import CoreData

class CoreDataServices {
    
    static let shared = CoreDataServices()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func savePosts(_ models: [PostModel]) {
        let context = AppDelegate.shared.persistentContainer.viewContext
        
        guard !models.isEmpty else {
            print(" No new posts to save. Skipping clear.")
            return
        }

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Post.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear old posts: \(error)")
        }
        
        for model in models {
            let post = Post(context: context)
            post.id = Int64(model.id)
            post.title = model.title
            post.body = model.body
            post.userName = model.userName
            post.isLiked = false
        }

        do {
            try context.save()
            print("Saved \(models.count) posts")
        } catch {
            print("Save failed: \(error)")
        }
    }

    func fetchPosts() -> [Post]{
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func toggleLike(for post: Post){
        post.isLiked.toggle()
        try? context.save()
    }
    
    func clearPost(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Post.fetchRequest()
        let deleteRequest: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? context.execute(deleteRequest)
    }
    
    
    private init() {}
}
