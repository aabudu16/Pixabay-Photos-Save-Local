//
//  FavoriteDetailedViewController.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FavoriteDetailedViewController: UIViewController {
    
    var favPhotos:FavoritePhotosModel!
    @IBOutlet var photo: UIImageView!
    
    @IBOutlet var likes: UILabel!
    @IBOutlet var views: UILabel!
    @IBOutlet var tags: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

     loadData()
    }



private func loadData(){
    
            likes.text = "Likes \(favPhotos.likes)"
            views.text = "Views \(favPhotos.views)"
            tags.text = "Tags \(favPhotos.tags)"
            
            let newImage = favPhotos.imageURL
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
