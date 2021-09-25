//
//  ImageRequest.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//

import Foundation
class ImageRequest: APIRequest {
    
    var method = RequestType.GET
    var path = "api"
    var parameters = [String: String]()

    init(tags: String) {
        parameters["key"] = "23559347-a03905a14004989fc27b72fbc"
        parameters["tags"] = tags
    }
}
