//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation

import UIKit
import Alamofire

public struct ServerCallModel {

    static let shared = ServerCallModel()

    public init() {
        
    }
    
    //MARK:- Fetch all streams API Call
    func getAllStreams(completion : @escaping (NSArray) -> Void) {
        let url = "\(baseUrl)ls"
        AF.request(url)
            .responseJSON { (response) in
                if let response = response.value {
                    let dataArray = ((response as! NSDictionary).object(forKey: "data") as! NSArray)
                    completion(dataArray)
                } else {
                    print(response.error.debugDescription)
                }
            }
    }
}
