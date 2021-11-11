
import KRProgressHUD
import UIKit

struct LiveStream_Package {
    
   
    init() {
    }
    
    func getStreams(searchValue : String)
    {
        LiveStreamViewModel.shared.getStreams(SearchValue: searchValue)
    }
    
}
