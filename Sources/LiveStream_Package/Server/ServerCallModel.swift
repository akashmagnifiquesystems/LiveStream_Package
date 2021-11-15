//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation

import UIKit
import Alamofire

struct ServerCallModel {

    static let shared = ServerCallModel()

    init() {
        
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
    
    func getMuxData()
    {
        let mux = Mux_Package()
        mux.createLiveStreamingCall { response in
            print("Mux Data=======", response)
            let responseObject = (response.object(forKey: "data") as! NSDictionary)
            UserDefaultsConstants.shared.saveToUserDefault(value: (responseObject.object(forKey: "stream_key") as! String), Key: "mux_stream_key")
            UserDefaultsConstants.shared.saveToUserDefault(value: (responseObject.object(forKey: "id") as! String), Key: "mux_broadcaster_id")
            
            let playbackId = (((responseObject.object(forKey: "playback_ids") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "id") as! String)
            UserDefaultsConstants.shared.saveToUserDefault(value: playbackId, Key: "mux_playback_id")
        }
    }
}
