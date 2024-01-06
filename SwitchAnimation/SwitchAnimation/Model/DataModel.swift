//
//  DataModel.swift
//  SwitchAnimation
//
//  Created by Admin on 06/01/24.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: String
    let title: String
    let date: Date
    let image: String
    let additionalImagesCount: Int
}

struct Posts: Codable {
    let posts: [Post]
}

func loadPosts() -> [Post] {
    guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else {
        fatalError("Failed to locate Data.json in bundle.")
    }

    guard let data = try? Data(contentsOf: url) else {
        fatalError("Failed to load Data.json from bundle.")
    }

    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    decoder.dateDecodingStrategy = .formatted(formatter)

    guard let loaded = try? decoder.decode(Posts.self, from: data) else {
        fatalError("Failed to decode Data.json from bundle.")
    }

    return loaded.posts
}
