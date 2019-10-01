//
//  PhotosDetailViewController.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController {
    
    var photos:Hit!
    @IBOutlet var photo: UIImageView!
    
    @IBOutlet var likes: UILabel!
    @IBOutlet var views: UILabel!
    @IBOutlet var tags: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

     setupView()
    }
    
   private func setupView(){
        likes.text = "Likes \(photos.likes!)"
        views.text = "Views \(photos.views!)"
        tags.text = "Tags \(photos.tags!)"
        
        if let newImage = photos.largeImageURL{
            ImageHelper.shared.getImage(urlStr: newImage) {
                (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                       self.photo.image = image
                    }
                }
            }
        }
        
    }
    @IBAction func favorite(_ sender: UIButton) {
        
        let myFav = FavoritePhotosModel(likes: photos.likes ?? 0, views: photos.views ?? 0, imageURL: photos.largeImageURL ?? "", tags: photos.tags ?? "")
        DispatchQueue.global(qos: .utility).async {
             try? PhotoPersistenceHelper.manager.save(newPhoto: myFav)
            
            self.navigationController?.popViewController(animated: true)
            
        }
      
    }
}
