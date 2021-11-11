//
//  File.swift
//  
//
//  Created by Aakash Patel on 11/11/21.
//

import Foundation
import KRProgressHUD


class LiveStreamViewModel {
    
    static let shared = LiveStreamViewModel()

    var livestreams : [Livestream] = []
    var upcomingstreams : [Upcomingstream] = []
    var filteredLivestreams : [Livestream] = []
    var filteredTrendingLivestreams : [Livestream] = []
    var filteredUpcomingstreams : [Upcomingstream] = []
    var trendingStreamDataCheck : Bool = false
    var newStreamDataCheck : Bool = false
    
    init() {
    }
    
    //MARK:- Binding data for listing
    func getStreams(completion: @escaping (NSArray) -> Void)
    {
        KRProgressHUD.show()
        ServerCallModel.shared.getAllStreams { responseArray in
            KRProgressHUD.dismiss()
            completion(responseArray)
        }
    }
    
    //MARK:- Live Stream Filter
    func liveStreamFilter(searchText : String)
    {
        if searchText.count == 0
        {
            self.filteredLivestreams = self.livestreams
            self.filteredTrendingLivestreams = []
            for i in 0 ..< self.livestreams.count
            {
                if self.filteredTrendingLivestreams.count < 5
                {
                    if Int(truncating: self.livestreams[i].currentViewers) > 1000
                    {
                        self.filteredTrendingLivestreams.append(self.livestreams[i])
                    }
                }
                self.filteredLivestreams.append(self.livestreams[i])
            }
        } else {
            self.filteredLivestreams = []
            self.filteredTrendingLivestreams = []
            
            for i in 0 ..< self.livestreams.count
            {
                if (self.livestreams[i].ls_broadcaster_primary_store.object(forKey: "name") as? String ?? "").lowercased().contains(searchText.lowercased()) || self.livestreams[i].title.lowercased().contains(searchText.lowercased())
                {
                    self.filteredLivestreams.append(self.livestreams[i])
                    if self.filteredTrendingLivestreams.count < 5
                    {
                        if Int(truncating: self.livestreams[i].currentViewers) > 0
                        {
                            self.filteredTrendingLivestreams.append(self.livestreams[i])
                        }
                    }
                }
            }
        }
        if filteredTrendingLivestreams.count > 0
        {
            trendingStreamDataCheck = false
        } else {
            trendingStreamDataCheck = true
        }
        
        if filteredLivestreams.count > 0
        {
            newStreamDataCheck = false
        } else {
            newStreamDataCheck = true
        }
    }
    
    //MARK:- Upcoming Stream Filter
    func upcomingStreamFilter(searchText : String)
    {
        if searchText.count == 0
        {
            self.filteredUpcomingstreams = self.upcomingstreams
            
        } else {
            self.filteredUpcomingstreams = []
            for i in 0 ..< self.upcomingstreams.count
            {
                if self.upcomingstreams[i].description.lowercased().contains(searchText.lowercased()) || (self.upcomingstreams[i].ls_broadcaster_primary_store.object(forKey: "name") as? String ?? "").lowercased().contains(searchText.lowercased())
                {
                    self.filteredUpcomingstreams.append(self.upcomingstreams[i])
                }
            }
        }
        if filteredUpcomingstreams.count > 0
        {
            newStreamDataCheck = false
        } else {
            newStreamDataCheck = true
        }
    }
}
