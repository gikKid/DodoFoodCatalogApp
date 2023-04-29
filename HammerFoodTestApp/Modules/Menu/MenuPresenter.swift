import UIKit

enum MenuState {
    case none, fetching, fetched
}

class MenuPresenter: ViewToPresenterMenuProtocol {
    
    var view: PresenterToViewMenuProtocol?
    var interactor: PresenterToInteractorMenuProtocol?
    var router: PresenterToRouterMenuProtocol?
    var state: MenuState = .none
    var food: FoodElement = .init(categories: [], id: "0")
    var promotions: [PromotionElement] = []
    var categorySnapshot: CategoryHeaderSnapshot = .init(categories: [], selectedIndex: 0)
    
    enum UIConstants {
        static let defaultItemsCount = 3
        static let sectionCount = 2
        static let promotionsSection = 0
        static let foodSection = 1
        static let firstCellRadius: CGFloat = 30.0
    }

    func viewDidLoad() {
        self.interactor?.fetchServerData()
        self.state = .fetching
        self.view?.reloadCollection()
    }
    
    func numberOfSections() -> Int {
        UIConstants.sectionCount
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        switch section {
        case UIConstants.promotionsSection:
            return self.state == .fetching ? UIConstants.defaultItemsCount : self.promotions.count
        case UIConstants.foodSection:
            return self.state == .fetching ? UIConstants.defaultItemsCount : self.food.categories[self.categorySnapshot.selectedIndex].content.count
        default: return 0
        }
    }
    
    func setCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case UIConstants.promotionsSection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identefiers.promotionCollectCell, for: indexPath) as? PromotionCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.errorHandler = { [weak self] errorMessage in
                self?.view?.showFailureAlert(errorMessage)
            }
            
            if state == .fetching && self.promotions.isEmpty {
                cell.showLoadingAnimation()
            } else {
                cell.configure(self.promotions[indexPath.row].imageurl)
            }
            
            return cell
            
        case UIConstants.foodSection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identefiers.foodCollectCell, for: indexPath) as? FoodCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.errorHandler = { [weak self] errorMessage in
                self?.view?.showFailureAlert(errorMessage)
            }
            
            if state == .fetching && self.food.categories.isEmpty {
                cell.showLoadingAnimation()
            } else {
                cell.configure(self.food.categories[self.categorySnapshot.selectedIndex].content[indexPath.row])
                
                indexPath.row == 0 ? cell.roundCorners(corners: [.topLeft,.topRight],
                                                       radius: UIConstants.firstCellRadius) : nil // in top food section we have rounded corners
            }
            
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func setHeader(_ collectionView: UICollectionView, _ kind: String, _ indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.Identefiers.categoryCollectionHeaderView, for: indexPath) as? CategoryCollectionReusableView
            else { return UICollectionReusableView() }
            header.configure(self.categorySnapshot)
            
            header.handleTap = { [weak self] index in
                self?.categorySnapshot.selectedIndex = index
                self?.view?.reloadFoodSection()
            }
            
            return header
        default: return UICollectionReusableView()
        }
    }
    
}

// MARK: - InteractorToPresenter
extension MenuPresenter: InteractorToPresenterMenuProtocol {
    func fetchServerDataSuccess(_ promotions: [PromotionElement],_ food: FoodElement) {
        self.promotions = promotions
        self.food = food
        self.categorySnapshot.categories = food.categories
        self.state = .fetched
        self.view?.reloadCollection()
    }
    
    func fetchServerDataFailure(errorMessage: String) {
        self.view?.showFailureAlert(errorMessage)
    }
}
