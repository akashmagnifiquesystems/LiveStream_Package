//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation

public struct Livestream {
    public var title : String
    public var isLivestreamActive : Bool
    public var bannersUrlArray : String
    public var description : String
    public var currentViewers : NSNumber
    public var timeStamp : String
    public var ls_broadcaster_primary_store : NSDictionary
    public var ls_broadcaster : NSDictionary
    public var ls_products : [LivestreamProduct]
    public var current_viewers : String
    public var ls_uuid : String
    
}

public struct Upcomingstream {
    public var title : String
    public var isLivestreamActive : Bool
    public var bannersUrlArray : String
    public var description : String
    public var currentViewers : NSNumber
    public var timeStamp : String
    public var ls_broadcaster_primary_store : NSDictionary
    public var ls_broadcaster : NSDictionary
    public var ls_products : [LivestreamProduct]
    public var current_viewers : String
    public var ls_uuid : String
}

public struct LivestreamProduct {
    public var imagesUrlArray : [String]
    public var starRating : String
    public var productAttributes : ProductAttributes
    public var description : String
    public var id : String
    public var numberOfReviews : String
    public var title : String
    public var category : String
    public var brand : String
    
}

public struct ProductAttributes {
    public var productUnitPrice : String
    public var productUnit : String
    public var productTotalQty : String
}
public struct Comments {
    public var comment : String
    public var receiver_image : String
    public var receiver_username : String
    public var receiver_uuid : String
    public var sender_image : String
    public var sender_username : String
    public var sender_uuid : String
    public var timeStamp : String
}
