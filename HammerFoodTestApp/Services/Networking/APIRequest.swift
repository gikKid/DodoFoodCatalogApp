import Foundation

class APIRequest<Resource: APIResource> {
    let resource: Resource
    let qos: DispatchQoS.QoSClass
    
    init(resource: Resource, qos: DispatchQoS.QoSClass) {
        self.resource = resource
        self.qos = qos
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
        DispatchQueue.global(qos: self.qos).async { self.load(self.resource.url, withCompletion: completion) }
    }
}
