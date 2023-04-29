import UIKit
import Foundation

protocol ImageLoader {
    func loadImage(_ url: String, qos: DispatchQoS.QoSClass, with completion: @escaping (UIImage?, Error?) -> Void )
}

extension ImageLoader {
    func loadImage(_ url: String, qos: DispatchQoS.QoSClass, with completion: @escaping (UIImage?, Error?) -> Void ) {
        guard let url = URL(string: url) else { return }
        let imageRequest = ImageRequest(url: url, qos: .userInteractive)
        imageRequest.execute { image, error in
            if let error = error {
                DispatchQueue.main.async { completion(nil,error) }
                return
            }
            guard let image = image else { return }
            DispatchQueue.main.async { completion(image,nil) }
        }
    }
}
