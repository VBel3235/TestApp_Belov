//
//  VBError.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import Foundation

enum VBError: String, Error{
    
case unableToComplete               = "Request was not completed"
case invalidResponse                = "Invalid reponse"
case invalidData                    = "Invalid data from the server"
case unableToDownloadPhotos         = "Unable to download photos"
    
}
