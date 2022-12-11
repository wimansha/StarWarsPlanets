//
//  PlanetsPack.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-26.
//

import Foundation

struct PlanetsPack : Codable {
    var count: Int
    var next: URL?
    var previous: URL?
    var results: [Planet]?
}
