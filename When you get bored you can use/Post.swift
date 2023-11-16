//
//  Post.swift
//  When you get bored you can use
//
//  Created by 123 on 16.11.23.
//
import Foundation

struct Bored: Decodable {
    let activity: String
    let type: String
    let participants: Int
    let price: Double
    let link: String?
    let key: String
    let accessibility: Double
}
