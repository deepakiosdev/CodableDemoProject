//
//  ViewController.swift
//  CodableDemoProject
//
//  Created by Dipak on 31/05/18.
//  Copyright © 2018 Dipak. All rights reserved.
//


import Foundation
import UIKit

struct RestClient {
    
    let imageCache = NSCache<NSString, UIImage>()

    enum Response<Value> {
        case success(Value)
        case failure(Error)
    }
    
    static func getSchoolsData(url: String, completion: ((Response<[School]>) -> Void)?) {
        
        let url = URL.init(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                // Now we have jsonData, Data representation of the JSON returned to us
                // from our URLRequest...
                
                // Create an instance of JSONDecoder to decode the JSON data to our
                // Codable struct
                let decoder = JSONDecoder()
                
                do {
                    // We would use School.self for JSON representing a single School
                    // object, and [School].self for JSON representing an array of
                    // School objects
                    let schools = try decoder.decode([School].self, from: jsonData)
                    completion?(.success(schools))
                } catch {
                    completion?(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion?(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    static func getDataFromUrl(url: String, completion: ((Response<Any>) -> Void)?) {
        let url = URL.init(string: url)

        URLSession.shared.dataTask(with: url!) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion?(.failure(error))
                } else if let data = responseData {
                    completion?(.success(data))
                    print("Download Finished")
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
            }.resume()
    }
    
}

