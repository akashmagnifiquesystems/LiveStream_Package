
import UIKit

public struct LiveStream_Package {
    
   
    public init() {
    }
    
    public func getStreams(searchValue : String,  completion: @escaping ([Livestream], [Upcomingstream]) -> Void)
    {
        LiveStreamViewModel.shared.getStreams(SearchValue: searchValue, completion: {liveStream,Upcomingstream in
            completion(liveStream, Upcomingstream)
        })
    }
    
}
