//
//  Rocket.swift
//  RocketLaunchApp
//
//  Created by Dhaval Trivedi on 31/05/21.
//

import Foundation

class Rocket: Codable {
    let rocket: RocketDetail?
    let isBooked: Bool?
}

class RocketDetail: Codable {
    let __typename: String?
    let name: String?
    let type: String?
}
