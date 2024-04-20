//
//  NewsModel.swift
//  lecture18
//
//  Created by MacBook Pro on 19.04.24.
//

import Foundation

struct NewsData: Decodable {
    let list: [News]
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
    }
    
}

struct News: Decodable {
    let title: String
    let time: String
    let photoUrl: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case time = "Time"
        case photoUrl = "PhotoUrl"
    }
    
}
