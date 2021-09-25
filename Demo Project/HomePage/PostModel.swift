//
//  PostModel.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//

import Foundation
import UIKit
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let postModel = try? newJSONDecoder().decode(PostModel.self, from: jsonData)

import Foundation

// MARK: - PostModel
class PostModel: Codable {
    let total, totalHits: Int
    let hits: [Hit]

    init(total: Int, totalHits: Int, hits: [Hit]) {
        self.total = total
        self.totalHits = totalHits
        self.hits = hits
    }
}

// MARK: - Hit
class Hit: Codable {
    let id: Int
    let pageURL: String
    let type, tags: String
    let previewURL: String
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL, fullHDURL, imageURL: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, likes, comments, userID: Int
    let user: String
    let userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, fullHDURL, imageURL, imageWidth, imageHeight, imageSize, views, downloads, likes, comments
        case userID
        case user, userImageURL
    }

    init(id: Int, pageURL: String, type: String, tags: String, previewURL: String, previewWidth: Int, previewHeight: Int, webformatURL: String, webformatWidth: Int, webformatHeight: Int, largeImageURL: String, fullHDURL: String, imageURL: String, imageWidth: Int, imageHeight: Int, imageSize: Int, views: Int, downloads: Int, likes: Int, comments: Int, userID: Int, user: String, userImageURL: String) {
        self.id = id
        self.pageURL = pageURL
        self.type = type
        self.tags = tags
        self.previewURL = previewURL
        self.previewWidth = previewWidth
        self.previewHeight = previewHeight
        self.webformatURL = webformatURL
        self.webformatWidth = webformatWidth
        self.webformatHeight = webformatHeight
        self.largeImageURL = largeImageURL
        self.fullHDURL = fullHDURL
        self.imageURL = imageURL
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imageSize = imageSize
        self.views = views
        self.downloads = downloads
        self.likes = likes
        self.comments = comments
        self.userID = userID
        self.user = user
        self.userImageURL = userImageURL
    }
}
