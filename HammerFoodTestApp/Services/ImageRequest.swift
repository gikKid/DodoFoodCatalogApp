import UIKit

class ImageRequest {
    let url: URL
    let qos: DispatchQoS.QoSClass
    
    init(url: URL, qos: DispatchQoS.QoSClass) {
        self.url = url
        self.qos = qos
    }
}

extension ImageRequest: NetworkRequest {
    func execute(withCompletion completion: @escaping (UIImage?, NetworkError?) -> Void) {
        DispatchQueue.global(qos: self.qos).async{ self.load(self.url, withCompletion: completion) }
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
