//
//  StringExtension.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/11/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
