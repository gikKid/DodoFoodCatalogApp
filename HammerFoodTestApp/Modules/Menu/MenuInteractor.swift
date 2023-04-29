import Foundation

class MenuInteractor: PresenterToInteractorMenuProtocol {

    var presenter: InteractorToPresenterMenuProtocol?
    
    func fetchServerData() {
        let dispatchGroup = DispatchGroup()
        var promotions: [PromotionElement] = []
        var food: [FoodElement] = []
        
        self.fetchPromotionData(dispatchGroup) { data in
            promotions = data
        }
        
        self.fetchFoodData(dispatchGroup) { data in
            food = data
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.fetchServerDataSuccess(promotions, food)
        }
    }
    
    
    private func fetchPromotionData(_ dispatchGroup: DispatchGroup,
                                    with completion: @escaping ([PromotionElement]) -> Void ) {
        dispatchGroup.enter()
        let promotionResource = PromotionResource()
        let promotionApiRequest = APIRequest(resource: promotionResource)
        
        promotionApiRequest.execute { result, error in
            if let error = error {
                self.presenter?.fetchServerDataFailure(errorMessage: error.localizedDescription)
                return
            }
            guard let result = result else { return }
            DispatchQueue.main.async { completion(result) }
            dispatchGroup.leave()
        }
    }
    
    private func fetchFoodData(_ dispatchGroup: DispatchGroup ,with completion: @escaping ([FoodElement]) -> Void ) {
        dispatchGroup.enter()
        let foodResource = FoodResource()
        let foodApiRequest = APIRequest(resource: foodResource)
        
        foodApiRequest.execute { result, error in
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
