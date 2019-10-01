//
//  ViewController.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet var photoCollectionView: UICollectionView!
    

    @IBOutlet var photoSearchBar: UISearchBar!
    
    var photos = [Hit](){
        didSet{
            photoCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
    }
    
   private func setupView(){
        photoSearchBar.delegate = self
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
   private func loadData(search:String){
        PhotoAPIClient.shared.getData(searchTerm: search) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let photo):
                    self.photos = photo
                }
            }
        }
    }
}

extension PhotoViewController: UICollectionViewDelegate{}

extension PhotoViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        
        let info = photos[indexPath.item]
        
        if let newImage = info.largeImageURL{
            ImageHelper.shared.getImage(urlStr: newImage) {
                (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell.photos.image = image
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photoDetailedVC = storyboard?.instantiateViewController(withIdentifier: "PhotosDetailViewController") as? PhotosDetailViewController else {return}
        
        let info = photos[indexPath.item]
        
        photoDetailedVC.photos = info
        
        self.navigationController?.pushViewController(photoDetailedVC, animated: true)
    }
    
}

extension PhotoViewController: UISearchBarDelegate{
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadData(search: searchBar.text ?? "")
    }
}
