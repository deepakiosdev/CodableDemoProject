//
//  ViewController.swift
//  CodableDemoProject
//
//  Created by Dipak on 31/05/18.
//  Copyright © 2018 Dipak. All rights reserved.
//


import Foundation




struct School: Codable {
    let schoolCode: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case schoolCode = "school_code"
        case url
    }
}


