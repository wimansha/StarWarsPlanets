//
//  Planet.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-26.
//

import Foundation

struct Planet : Codable {
    var name: String?
    var climate: String?
    var orbitalPeriod : String?
    var gravity: String?
    
    var index: Int?
    var thumbnailURL: URL {
        return URL(string: "https://picsum.photos/id/\(index ?? 0)/200/300")!
    }
    var imageURL: URL {
        return URL(string: "https://picsum.photos/id/\(index ?? 0)/800/800")!
    }
}
