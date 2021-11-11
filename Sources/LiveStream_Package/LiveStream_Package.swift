
import UIKit

public struct LiveStream_Package {
    
   
    public init() {
    }
    
    public func getStreams(searchValue : String,  completion: @escaping (NSArray) -> Void)
    {
        LiveStreamViewModel.shared.getStreams(SearchValue: searchValue, completion: {responseArray in
            completion(responseArray)
        })
    }
    
}
