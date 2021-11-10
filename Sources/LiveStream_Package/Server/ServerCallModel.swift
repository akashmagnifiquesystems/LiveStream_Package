//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation

import UIKit

public struct ServerCallModel {

    let serverCallModel = ServerCallModel()

    public init() {
        
    }
    
    //MARK:- Create Live Streaming
    public func createLiveStreamingCall(completion: @escaping (NSDictionary) -> Void) {
        apiCallHelper.call_Create_Live_Streaming { response in
            completion(response)
        }
    }
}
