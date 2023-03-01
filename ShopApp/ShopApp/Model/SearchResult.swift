//
//  Model.swift
//  ShopApp
//
//  Created by Abduraxmon on 20/02/23.
//

import Foundation

class SearchResult: Codable {
    
    var trackName: String? = ""
    var artistName: String? = ""
    var trackPrice: Double? = 0.0
    var artistViewUrl = ""
    var artworkUrl60 = ""
    var artworkUrl100 = ""
    var primaryGenreName = ""
    var wrapperType = ""
    
    
    var name: String {
        return trackName ?? ""
    }
    
}

class ResultArray: Codable {
    
    var resultCount: Int = 0
    var results: [SearchResult]? = []
    
}
