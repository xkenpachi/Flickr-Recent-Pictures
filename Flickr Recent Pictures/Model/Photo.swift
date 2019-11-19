//
//  File.swift
//  Flickr Recent Pictures
//
//  Created by Emre Öner on 18.11.2019.
//  Copyright © 2019 Emre Öner. All rights reserved.
//

import Foundation


struct Photo: Codable  {
    var id: String
    var owner: String
    var title: String
    var farm: String
    var isPublic: String
    var isFriend: String
    var isFamily: String
    var server: String
    var secret: String
}
