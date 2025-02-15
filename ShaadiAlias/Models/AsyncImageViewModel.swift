//
//  AsyncImageViewModel.swift
//  ShaadiAlias
//
//  Created by Aakarsh Verma on 17/12/24.
//

import Foundation

class AsyncImageViewModel {
    let imageAssest: String
    let placeholderImage: String
    
    init(imageAssest: String, placeholderImage: String = "person.fill") {
        self.imageAssest = imageAssest
        self.placeholderImage = placeholderImage
    }
    
    func checkToDownloadImage() -> Bool {
        if imageAssest.contains("https") || imageAssest.contains("http") {
            return true
        }
        return false
    }
}
