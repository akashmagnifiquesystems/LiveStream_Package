
import KRProgressHUD
import UIKit

public struct LiveStream_Package {
    
   
    public init() {
    }
    
    public func getStreams(searchValue : String)
    {
        LiveStreamViewModel.shared.getStreams(SearchValue: searchValue)
    }
    
}
