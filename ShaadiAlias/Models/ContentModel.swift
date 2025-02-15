//
//  ContentModel.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 17/12/24.
//

import Foundation

struct ContentModel: Codable {
    var identifier = UUID()
    var value: String?
    var fullName, address, image: String?
    var isAccepted: Bool?
    var imageData: Data?
}
