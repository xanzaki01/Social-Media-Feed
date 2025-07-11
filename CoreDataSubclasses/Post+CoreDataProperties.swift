//
//  Post+CoreDataProperties.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 09/07/25.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var userName: String?
    @NSManaged public var avatarURL: String?
    @NSManaged public var isLiked: Bool

}

extension Post : Identifiable {

}
