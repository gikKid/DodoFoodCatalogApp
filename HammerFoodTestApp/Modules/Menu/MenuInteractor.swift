import Foundation
import Combine

class MenuInteractor: PresenterToInteractorMenuProtocol {
    
    var presenter: InteractorToPresenterMenuProtocol?
    
    func fetchServerData() {
        
        if Reachability.isConnectedToNetwork() {
            let dispatchGroup = DispatchGroup()
            var promotions: [PromotionElement] = []
            var food: [FoodElement] = []
            let promotionAPIRequest = APIRequest(resource: PromotionResource(), qos: .userInitiated)
            let foodAPIRequest = APIRequest(resource: FoodResource(), qos: .userInitiated)
            
            self.fetchData(promotionAPIRequest, dispatchGroup) { result in
                promotions = result
            }
            
            self.fetchData(foodAPIRequest, dispatchGroup) { result in
                food = result
            }
            
            dispatchGroup.notify(queue: .main) {
                guard let food = food.first else { return } // in API we get array w/ only 1 element
                self.presenter?.fetchServerDataSuccess(promotions, food)
            }
        } else {
            self.presenter?.fetchServerDataFailure(errorMessage: NetworkError.connection.description)
        }
    }
    
    
    private func fetchData<T: APIResource>(_ apiRequest:APIRequest<T>, _ dispatchGroup: DispatchGroup,
                                           with completion: @escaping  ([T.ModelType]) -> Void ) {
        dispatchGroup.enter()
        
        apiRequest.execute { result, error in
            if let error = error {
                self.presenter?.fetchServerDataFailure(errorMessage: error.localizedDescription)
                return
            }
            
            guard let result = result else { return }
            DispatchQueue.main.async { completion(result) }
            dispatchGroup.leave()
        }
    }
}
