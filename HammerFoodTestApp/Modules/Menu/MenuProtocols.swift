import UIKit

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMenuProtocol {
    var view: PresenterToViewMenuProtocol? { get set }
    var interactor: PresenterToInteractorMenuProtocol? { get set }
    var router: PresenterToRouterMenuProtocol? { get set}
    var categorySnapshot: CategoryHeaderSnapshot { get set }
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func setCell(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell
    func setHeader(_ collectionView: UICollectionView,_ kind: String,_ indexPath: IndexPath) -> UICollectionReusableView
}

//MARK: - View Outpur (Presenter -> View)
protocol PresenterToViewMenuProtocol {
    func reloadCollection()
    func reloadFoodSection()
    func showFailureAlert(_ errorMessage: String)
}

//MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMenuProtocol {
    var presenter: InteractorToPresenterMenuProtocol? { get set }
    func fetchServerData()
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMenuProtocol {
    func fetchServerDataSuccess(_ promotions: [PromotionElement],_ food: [FoodElement])
    func fetchServerDataFailure(errorMessage: String)
}

//MARK: - Router Inout (Presenter -> Router)
protocol PresenterToRouterMenuProtocol {}
