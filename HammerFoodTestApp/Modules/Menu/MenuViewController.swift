import UIKit
import SnapKit

class MenuViewController: BaseViewController {
    
    let locationView = LocationView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var presenter: (ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    //MARK: - Setup view
    override func addViews() {
        self.view.addSubview(locationView)
        self.view.addSubview(collectionView)
    }
    
    override func configure() {
        super.configure()
        locationView.configure("Москва") // FIXME: - HARDCODE !!!
        self.configureCollection()
    }
    
    
    override func layoutViews() {
        locationView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(UIConstants.locationViewOffsets)
            make.leading.equalToSuperview().offset(UIConstants.leftOffset)
            make.height.equalTo(UIConstants.locationViewHeight)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


//MARK: - Collection methods
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter?.setCell(collectionView, indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        presenter?.setHeader(collectionView, kind, indexPath) ?? UICollectionReusableView()
    }
}

//MARK: - PresenterToViewProtocol
extension MenuViewController: PresenterToViewMenuProtocol {
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func reloadFoodSection() {
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: MenuPresenter.UIConstants.foodSection))
        }
    }
    
    func showFailureAlert(_ errorMessage: String) {
        self.present(self.createInfoAlert(message: errorMessage, title: Constants.Titles.OK),animated: true)
    }
}



private extension MenuViewController {
    enum UIConstants {
        static let locationViewOffsets: CGFloat = 20.0
        static let collectionTopOffset: CGFloat = 20.0
        static let categoryHeaderHeight: CGFloat = 50.0
        static let promotionHeight: CGFloat = 112.0
        static let locationViewHeight: CGFloat = 50.0
        static let leftOffset: CGFloat = 15.0
        static let promotionItemRightOffset: CGFloat = 15.0
        static let foodItemBottomOffset: CGFloat = 1.0
    }
    
    func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = self.createCompositionLayout()
        
        collectionView.register(PromotionCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.Identefiers.promotionCollectCell)
        collectionView.register(FoodCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.Identefiers.foodCollectCell)
        collectionView.register(CategoryCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Constants.Identefiers.categoryCollectionHeaderView)
    }
    
    func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        let layout =  UICollectionViewCompositionalLayout { (section,_) -> NSCollectionLayoutSection? in
            switch section {
            case MenuPresenter.UIConstants.promotionsSection: return self.promotionsLayoutSection()
            case MenuPresenter.UIConstants.foodSection: return self.foodLayoutSection()
            default: return nil
            }
        }
        return layout
    }
    
    
    func promotionsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(UIConstants.promotionHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: UIConstants.promotionItemRightOffset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),heightDimension: .fractionalWidth(0.35))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: UIConstants.leftOffset, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func foodLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalWidth(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: UIConstants.foodItemBottomOffset, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        
        return section
    }
    
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem.init(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .estimated(UIConstants.categoryHeaderHeight)),elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
        headerElement.pinToVisibleBounds = true
        
        return headerElement
    }
}
