//
//  UIITextFiledExtension.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/11/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

extension UITextField {
    
    func error(error: String) {
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
        self.text = ""
        self.placeholder = error
    }
    
    func success() {
        let def = UITextView()
        self.layer.borderWidth = def.layer.borderWidth
        self.layer.cornerRadius = def.layer.cornerRadius
        self.layer.borderColor = def.layer.borderColor
        self.placeholder = ""
        self.text = ""
    }
}
