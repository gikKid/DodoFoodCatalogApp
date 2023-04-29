import UIKit

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func execute(withCompletion completion: @escaping (UIImage?, NetworkError?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async{ self.load(self.url, withCompletion: completion) }
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
