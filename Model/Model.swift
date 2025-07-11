//
//  Model.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 09/07/25.
//

import UIKit

struct PostModel: Codable {
    let userName: String
    let id: Int
    let title: String
    let body: String
}
