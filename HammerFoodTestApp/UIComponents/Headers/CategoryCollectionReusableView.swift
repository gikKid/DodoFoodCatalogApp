import UIKit
import SnapKit



class CategoryCollectionReusableView: UICollectionReusableView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var handleTap: ((_ index: Int) -> Void)?
    private var snapshot = CategoryHeaderSnapshot(categories: [], selectedIndex: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ snapshot: CategoryHeaderSnapshot) {
        self.snapshot = snapshot
        self.reloadCollection(snapshot.selectedIndex)
    }
}


//MARK: - Collection methods
extension CategoryCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.snapshot.categories.count == 0 ? UIConstants.defaultItemsCount : self.snapshot.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identefiers.categoryCollectCell, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        self.snapshot.categories.count == 0 ? cell.showLoadingAnimation() : cell.configure(self.snapshot.categories[indexPath.row].name)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleTap?(indexPath.row)
    }
}


private extension CategoryCollectionReusableView {
    
    enum UIConstants {
        static let leftOffset: CGFloat = 15.0
        static let defaultItemsCount = 1
        static let itemWidth: CGFloat = 100.0
        static let itemHeight: CGFloat = 32.0
        static let itemRightOffset : CGFloat = 10.0
    }

    
    //MARK: - Private setup view
    func setupView() {
        self.backgroundColor = UIColor(named: Constants.Colors.Custom.backgroundViewColor)
        self.addSubview(collectionView)
        self.configureCollection()
    }
    
    func configureCollection() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = self.createCompositionLayout()
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identefiers.categoryCollectCell)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section,_) -> NSCollectionLayoutSection? in
            switch section {
            case 0: return self.categoryLayoutSection()
            default: return nil
            }
        }
    }
    
    func categoryLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(UIConstants.itemWidth),heightDimension: .absolute(UIConstants.itemHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: UIConstants.itemRightOffset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(UIConstants.itemWidth),heightDimension: .estimated(UIConstants.itemHeight))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: UIConstants.leftOffset, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func reloadCollection(_ selectIndex: Int) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.selectItem(at: IndexPath(item: selectIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
}
