//
//  FavoriteViewController.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet var favoriteTableView: UITableView!
    var myFavorite = [FavoritePhotosModel](){
        didSet{
            self.favoriteTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupView()
    }
    
    private func setupView(){
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    private func getData(){
        do{
            myFavorite = try PhotoPersistenceHelper.manager.getPhotos()
            self.favoriteTableView.reloadData()
        }catch{
            print(error)
        }
        
    }
}

extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension FavoriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as? FavoriteTableViewCell else {return UITableViewCell()}
        
        let info = myFavorite[indexPath.row]
        ImageHelper.shared.getImage(urlStr: info.imageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.favoriteImage.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailedVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteDetailedViewController") as? FavoriteDetailedViewController else {return}
        
        let info = myFavorite[indexPath.row]
       detailedVC.favPhotos = info
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
}
