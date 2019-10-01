//
//  PhotoPersistenceHelper.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    static let manager = PhotoPersistenceHelper()
    
    func save(newPhoto: FavoritePhotosModel) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhotos() throws -> [FavoritePhotosModel] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<FavoritePhotosModel>(fileName: "photos.plist")
    
    private init() {}
}
