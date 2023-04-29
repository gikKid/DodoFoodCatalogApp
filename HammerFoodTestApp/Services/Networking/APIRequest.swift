import Foundation

class APIRequest<Resource: APIResource> {
    var resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let result = try? decoder.decode([Resource.ModelType].self, from: data)
        return result
    }
    
    func execute(withCompletion completion: @escaping ([Resource.ModelType]?, NetworkError?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { self.load(self.resource.url, withCompletion: completion) }
    }
}
