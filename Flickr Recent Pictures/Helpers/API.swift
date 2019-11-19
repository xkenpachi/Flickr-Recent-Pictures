//
//  API.swift
//  Flickr Recent Pictures
//
//  Created by Emre Öner on 18.11.2019.
//  Copyright © 2019 Emre Öner. All rights reserved.
//

import Foundation


class API: NSObject {
    
    static let instance = API()
    
    private override init() {}
    
    private var elementName: String!
    private var found: String!

    private var photos = [Photo]()
    private var photo: Photo!
    
    private var photoCount = 20
    
    func getRecentImages(pageNumber: Int, completion: @escaping ([Photo]) -> Void)  {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=c2f49b1d699840ba3ad14c3d115fb33b&per_page=\(photoCount)&page=\(pageNumber)&format=rest") else {return}
        
        let req = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            guard let xmlString = String(data: data!, encoding: .utf8) else {return}
            guard let xmlData = xmlString.data(using: .utf8) else {return}
            let parser = XMLParser(data: xmlData)
            parser.delegate = self
            parser.parse()
            
            completion(self.photos)
            self.photos.removeAll()
        }
        task.resume()
    }
    
}

extension API: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
      
        if elementName == "photo" {
        
            guard let isFriend = attributeDict["isfriend"], let farm = attributeDict["farm"], let id = attributeDict["id"], let isPublic = attributeDict["ispublic"], let server = attributeDict["server"] , let secret = attributeDict["secret"], let isFamily = attributeDict["isfamily"], let title = attributeDict["title"], let owner = attributeDict["owner"] else {return}
            
            photo = Photo(id: id, owner: owner, title: title, farm: farm, isPublic: isPublic, isFriend: isFriend, isFamily: isFamily, server: server, secret: secret)
    
            photos.append(photo)
            
        }
    }
}
