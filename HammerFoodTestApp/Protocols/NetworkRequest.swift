import Foundation


protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?,NetworkError?) -> Void)
}


extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?, NetworkError?) -> Void) {
                
        let task = URLSession.shared.dataTask(with: url) { (data, _ , error) in
            if let error = error {
                DispatchQueue.main.async { completion(nil, .undefained(error.localizedDescription)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(nil, NetworkError.data) }
                return
            }
            
            guard let value = self.decode(data) else {
                DispatchQueue.main.async { completion(nil, .parse) }
                return
            }
            
            DispatchQueue.main.async { completion(value, nil) }
        }
        task.resume()
    }
}


enum NetworkError:Error {
    case data,parse
    case undefained(String)
    
    var description:String {
        switch self {
        case .data: return Constants.Error.dataNetwork
        case .parse: return Constants.Error.parseNetwork
        case .undefained(let string): return string
        }
    }
}
