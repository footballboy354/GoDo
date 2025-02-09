//
//  Post.swift
//  GoDo
//
//  Created by わだわだ on 2024/11/24.
//

import Foundation

struct Post: Codable {
    let id: String
    let title: String
    let userId: String
    let postImages: [String]
    let thumnailPost: String
    let crestedAt: String
}
