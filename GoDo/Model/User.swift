//
//  User.swift
//  GoDo
//
//  Created by わだわだ on 2024/11/24.
//

import Foundation

struct User: Codable {
    let following: String
    let followers: String
    let mutualFollowers: String
    let profileImage: String
    let profileName: String
    let userId: String
    let postImage: String
}
