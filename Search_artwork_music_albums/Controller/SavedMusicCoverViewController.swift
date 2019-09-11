//
//  SavedMusicCoverViewController.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/7/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class SavedMusicCoverViewController: UIViewController {
    
    var album: UserRequest?
    
    @IBOutlet weak var imageAlbums: UIImageView!
    @IBOutlet weak var nameAlbums: UILabel!
    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func getInfoFromCoreData() {
        if let album = album {
            self.nameAlbums.text = album.name
            self.imageAlbums.image = UIImage(data: Data(referencing: album.image!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoFromCoreData()
    }
}
