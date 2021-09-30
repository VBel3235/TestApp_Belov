//
//  Image.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import Foundation

import Foundation

// MARK: - Image
struct Image: Codable, Hashable {
    var total: Int
    var totalHits: Int
    var hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
}

// MARK: - Hit
struct Hit: Codable, Hashable {
    var id: Int
    var pageURL: String
    var type: String
    var tags: String
    var previewURL: String
    var previewWidth: Int
    var previewHeight: Int
    var webformatURL: String
    var webformatWidth: Int
    var webformatHeight: Int
    var largeImageURL: String
    var imageWidth: Int
    var imageHeight: Int
    var imageSize: Int
    var views: Int
    var downloads: Int
    var collections: Int
    var likes: Int
    var comments: Int
    var userid: Int
    var user: String
    var userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pageURL = "pageURL"
        case type = "type"
        case tags = "tags"
        case previewURL = "previewURL"
        case previewWidth = "previewWidth"
        case previewHeight = "previewHeight"
        case webformatURL = "webformatURL"
        case webformatWidth = "webformatWidth"
        case webformatHeight = "webformatHeight"
        case largeImageURL = "largeImageURL"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
        case imageSize = "imageSize"
        case views = "views"
        case downloads = "downloads"
        case collections = "collections"
        case likes = "likes"
        case comments = "comments"
        case userid = "user_id"
        case user = "user"
        case userImageURL = "userImageURL"
    }
}
