//
//  MainViewController.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/7/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    private let separatedSymbols: String = "-:|\\/~"
    private let requestManager = RequestManager()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func searchButto(_ sender: UIButton) {
        searchAttempt()
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        searchAttempt()
        dismissKeyboard()
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

extension MainViewController {
    
    func saveRequest(nameAlbum: String, imageAlbum: NSData) {
        //Duplicate check
        let newNameAlbum = nameAlbum.lowercased().capitalizingFirstLetter()
        let userRequests = CoreDataManager.instance.getArrayEntity(entityName: "UserRequest")
        for userRequest in userRequests {
            if userRequest.value(forKey: "name") as? String == newNameAlbum {
                return
            }
        }
        // Creating object
        let userRequest = UserRequest()
        // Saving object
        userRequest.name = newNameAlbum
        userRequest.image = imageAlbum as NSData
        CoreDataManager.instance.saveContext()
    }
    
    func tryGetImaga(urlImage: String, nameAlbum: String) {
        // Get image from URL
        if let newsImage = URL(string: urlImage) {
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                if let isNewsImage = try? Data(contentsOf: newsImage) {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.saveRequest(nameAlbum: nameAlbum, imageAlbum: isNewsImage as NSData)
                        self.imageAlbum.image = UIImage(data: isNewsImage)
                        self.imageAlbum.contentMode = .scaleAspectFit
                    }
                } else {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.alertMessage(title: "Error", message: "No database connection")
                    }
                }
            }
        } else {
            self.alertMessage(title: "Sorry", message: "There is no such album in the database")
        }
    }
    
    func searchAlbum(artistName: String, albumName: String) {
        // Request search cover Album
        requestManager.searchAlbum(artistName: artistName, albumName: albumName, completionHandler: { response, error  in
            if error == nil {
                self.activityIndicator.startAnimating()
                let artistNameSpace = artistName.replacingOccurrences(of: "_", with: " ")
                let albumNameSpace = albumName.replacingOccurrences(of: "_", with: " ")
                self.tryGetImaga(urlImage: response?["album"][0]["strAlbumThumb"].string ?? "", nameAlbum: "\(artistNameSpace) - \(albumNameSpace)")
                self.searchTextField.success()
            } else {
                self.searchTextField.error(error: error!)
            }
        })
    }
    
    func searchAttempt() {
        // Validation сheck and bigen
        if searchTextField.text != "" && searchTextField.text != nil {
            self.searchTextField.text = self.searchTextField.text?.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.joined(separator: " ")
            let separator = searchTextField.text?.filter(separatedSymbols.contains)
            if separator?.count == 1 {
                let nameArtAndAlb = searchTextField.text!.components(separatedBy: separator!)
                if nameArtAndAlb.count == 2 && nameArtAndAlb[0] != "" && nameArtAndAlb[1] != "" {
                    let artistName = nameArtAndAlb[0].trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "_")
                    let albumName = nameArtAndAlb[1].trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "_")
                    searchAlbum(artistName: artistName, albumName: albumName)
                } else {
                    alertMessage(title: "Error", message: "You must specify artist name and album title")
                }
            } else {
                alertMessage(title: "Error", message: "Artist name and album title in text field must be separated by only one next symbols: ‘-‘, ‘:’, ‘|’, ‘\\’, ‘/‘, ‘~’")
            }
        } else {
            self.searchTextField.error(error: "Text field is Empty")
        }
    }
    
    // Alert
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
