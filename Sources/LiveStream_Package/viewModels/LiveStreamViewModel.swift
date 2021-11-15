//
//  File.swift
//  
//
//  Created by Aakash Patel on 11/11/21.
//

import Foundation
import KRProgressHUD


public class LiveStreamViewModel {
    
    public static let shared = LiveStreamViewModel()
    
    var livestreams : [Livestream] = []
    var upcomingstreams : [Upcomingstream] = []
    var filteredLivestreams : [Livestream] = []
    var filteredTrendingLivestreams : [Livestream] = []
    var filteredUpcomingstreams : [Upcomingstream] = []
    var trendingStreamDataCheck : Bool = false
    var newStreamDataCheck : Bool = false
    
    public init() {
    }
    
    //MARK:- Binding data for listing
    public func getAllStreams(completion: @escaping ([Livestream], [Upcomingstream]) -> Void)
    {
        KRProgressHUD.show()
        ServerCallModel.shared.getAllStreams { responseArray in
            KRProgressHUD.dismiss()
            self.livestreams = []
            self.upcomingstreams = []
            
            for i in 0 ..< responseArray.count
            {
                let model = (responseArray.object(at: i) as! NSDictionary)
                if (model.object(forKey: "ls_scheduled_date") as! NSNumber) == 0
                {
                    self.livestreams.append(contentsOf: [Livestream(title: (model.object(forKey: "ls_title") as! String),
                                                                    isLivestreamActive: (model.object(forKey: "is_livestream_active") as? Bool ?? false),
                                                                    bannersUrlArray: ((model.object(forKey: "ls_banners_url_array") as! NSArray).object(at: 0) as! String),
                                                                    description: (model.object(forKey: "ls_description") as! String),
                                                                    currentViewers: (model.object(forKey: "current_viewers") as! NSNumber),
                                                                    timeStamp: Converter.shared.convertTime(timeStamp: (model.object(forKey: "ls_scheduled_date") as! Int)),
                                                                    ls_broadcaster_primary_store: (model.object(forKey: "ls_broadcaster_primary_store") as! NSDictionary),
                                                                    ls_broadcaster: (model.object(forKey: "ls_broadcaster") as! NSDictionary),
                                                                    ls_products: self.filterProductData(productArray: (model.object(forKey: "ls_products") as! NSArray)),
                                                                    current_viewers:  "\(Int(truncating: model.object(forKey: "current_viewers") as! NSNumber).roundedWithAbbreviations)",
                                                                    ls_uuid: (model.object(forKey: "ls_uuid") as! String))])
                }else{
                    self.upcomingstreams.append(contentsOf: [Upcomingstream(title: (model.object(forKey: "ls_title") as! String),
                                                                            isLivestreamActive: (model.object(forKey: "is_livestream_active") as? Bool ?? false),
                                                                            bannersUrlArray: ((model.object(forKey: "ls_banners_url_array") as! NSArray).object(at: 0) as! String),
                                                                            description: (model.object(forKey: "ls_description") as! String),
                                                                            currentViewers: (model.object(forKey: "current_viewers") as! NSNumber),
                                                                            timeStamp:  Converter.shared.convertTime(timeStamp: (model.object(forKey: "ls_scheduled_date") as! Int)),
                                                                            ls_broadcaster_primary_store: (model.object(forKey: "ls_broadcaster_primary_store") as! NSDictionary),
                                                                            ls_broadcaster: (model.object(forKey: "ls_broadcaster") as! NSDictionary),
                                                                            ls_products: self.filterProductData(productArray:(model.object(forKey: "ls_products") as! NSArray)),
                                                                            current_viewers: "\(Int(truncating: model.object(forKey: "current_viewers") as! NSNumber).roundedWithAbbreviations)",
                                                                            ls_uuid: (model.object(forKey: "ls_uuid") as! String))])
                }
            }
            if UserDefaults.standard.object(forKey: "mux_stream_key") == nil
            {
                ServerCallModel.shared.getMuxData()
            }
            completion(self.livestreams, self.upcomingstreams)
        }
    }
    
    func filterProductData(productArray : NSArray) -> [LivestreamProduct]
    {
        var prodArray = [LivestreamProduct]()
        for i in 0 ..< productArray.count
        {
            let model = (productArray[i] as! NSDictionary)
            let product_attributes = (model.object(forKey: "product_attributes") as! NSDictionary)
            
            let productAttributes = ProductAttributes(productUnitPrice: (product_attributes.object(forKey: "product_unit_price") as? String ?? "0"), productUnit: (product_attributes.object(forKey: "product_unit") as? String ?? "0"), productTotalQty: (product_attributes.object(forKey: "product_unit_price") as? String ?? "0"))
            
            prodArray.append(LivestreamProduct(imagesUrlArray: ((model.object(forKey: "imagesURL_array") as! NSArray) as! [String]),
                                               starRating: (model.object(forKey: "star_rating") as? String ?? "0"),
                                               productAttributes: productAttributes,
                                               description: (model.object(forKey: "description") as! String),
                                               id: (model.object(forKey: "id") as! String),
                                               numberOfReviews: (model.object(forKey: "number_of_reviews") as? String ?? "0"),
                                               title: (model.object(forKey: "title") as! String),
                                               category: (model.object(forKey: "category") as! String),
                                               brand: (model.object(forKey: "brand") as! String)))
        }
        return prodArray
    }
}
