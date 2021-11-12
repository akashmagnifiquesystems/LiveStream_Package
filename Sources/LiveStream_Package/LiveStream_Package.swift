
import UIKit

public struct LiveStream_Package {
    
    
    public init() {
    }
    
    //MARK:- get all stream
    public func getStreams(completion: @escaping ([Livestream], [Upcomingstream]) -> Void)
    {
        LiveStreamViewModel.shared.getAllStreams(completion: {liveStreamArray, upcomingStreamArray  in
            completion(liveStreamArray, upcomingStreamArray)
        })
    }
    
}
