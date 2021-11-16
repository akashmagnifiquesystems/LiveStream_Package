
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
    
    //MARK:- get all comments streamwise
    public func getAllCommentsByStream(roomID: String, completion: @escaping ([Comments]) -> Void)
    {
        FirestoreCommentViewModel.shared.getCommentList(roomID: roomID) { commetsArray in
            completion(commetsArray)
        }
    }

    
}
