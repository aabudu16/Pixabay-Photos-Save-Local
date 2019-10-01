//
//  CountryAPIClient.swift
//  iOS-Collection-View-Lab
//
//  Created by Mr Wonderful on 9/26/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct CountryAPIClient{
    
    static let shared = CountryAPIClient()
    
    func getCountryData(country:String, completionHandler: @escaping (Result<[Country],AppError>)->()){
       
        let countryURL = "https://restcountries.eu/rest/v2/name/\(country)"
      guard let url = URL(string: countryURL) else {
        completionHandler(.failure(.badUrl))
        return}
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do{
                    let countryData = try JSONDecoder().decode([Country].self, from: data)
                    completionHandler(.success(countryData))
                }catch{
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
    func fetchImage(imageSign:String)->String{
        return "https://www.countryflags.io/\(imageSign)/shiny/64.png"
    }
}
