//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation

struct Livestream {
    var title : String
    var isLivestreamActive : Bool
    var bannersUrlArray : String
    var description : String
    var currentViewers : NSNumber
    var timeStamp : String
    var ls_broadcaster_primary_store : NSDictionary
    var ls_broadcaster : NSDictionary
    var ls_products : [LivestreamProduct]
    var current_viewers : String
    var ls_uuid : String
    
}

struct Upcomingstream {
    var title : String
    var isLivestreamActive : Bool
    var bannersUrlArray : String
    var description : String
    var currentViewers : NSNumber
    var timeStamp : String
    var ls_broadcaster_primary_store : NSDictionary
    var ls_broadcaster : NSDictionary
    var ls_products : [LivestreamProduct]
    var current_viewers : String
    var ls_uuid : String
}

struct LivestreamProduct {
    var imagesUrlArray : [String]
    var starRating : String
    var productAttributes : ProductAttributes
    var description : String
    var id : String
    var numberOfReviews : String
    var title : String
    var category : String
    var brand : String
    
}

struct ProductAttributes {
    var productUnitPrice : String
    var productUnit : String
    var productTotalQty : String
}
