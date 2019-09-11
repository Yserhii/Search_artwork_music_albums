//
//  RequestManager.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/7/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RequestManager {
    private let secred_key = "195210"
    private let site = "https://www.theaudiodb.com/"
    
    func searchAlbum(artistName: String, albumName: String, completionHandler: @escaping(JSON?, String?)->Void) {
        let reqUrl = "\(site)api/v1/json/\(secred_key)/searchalbum.php?s=\(artistName)&a=\(albumName)"
        request(reqUrl).responseJSON { response in
            if response.result.isSuccess {
                guard let value = response.value else {
                    completionHandler(nil, "Not found")
                    return
                }
                let dict = JSON(value)
                if dict["album"].count == 0 {
                    completionHandler(nil, "Not found")
                } else {
                    completionHandler(dict, nil)
                }
            } else {
                completionHandler(nil, "Bad conections")
            }
        }.task?.resume()
    }
}
