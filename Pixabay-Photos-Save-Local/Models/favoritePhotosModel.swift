//
//  favoritePhotosModel.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct FavoritePhotosModel:Codable{
    let likes:Int
    let views:Int
    let imageURL:String
    let tags:String
}
