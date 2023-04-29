import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    var gradient = CAGradientLayer()
    
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? UIConstants.selectedColor : UIConstants.notSelectedColor
            nameLabel.font = isSelected ? UIConstants.selectedLabelFont : UIConstants.notSelectedLabelFont
            self.backgroundColor = isSelected ? UIColor(named: Constants.Colors.Custom.main)?.withAlphaComponent(0.2) : .clear
            self.layer.borderWidth = isSelected ? 0 : UIConstants.borderWidth
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ text:String) {
        self.nameLabel.text = text
        self.layer.borderWidth = isSelected ? 0 : UIConstants.borderWidth
        self.removeShimmer()
    }
}


extension CategoryCollectionViewCell: SkeletonLoadable {
    func showLoadingAnimation() {
        self.setShimmer(layer: self.contentView.layer, frame: self.bounds)
    }
}


private extension CategoryCollectionViewCell {
    
    enum UIConstants {
        static let borderWidth: CGFloat = 1.0
        static let labelSize: CGFloat = 13.0
        static let cornerRadius: CGFloat = 16.0
        static let notSelectedColor = UIColor(named: Constants.Colors.Custom.main)?.withAlphaComponent(0.4)
        static let selectedColor = UIColor(named: Constants.Colors.Custom.main)
        static let notSelectedLabelFont = UIFont.systemFont(ofSize: UIConstants.labelSize)
        static let selectedLabelFont = UIFont.boldSystemFont(ofSize: UIConstants.labelSize)
    }
    
    //MARK: - Private setup view
    func setupView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = UIConstants.cornerRadius
        self.layer.borderColor = UIColor(named: Constants.Colors.Custom.main)?.withAlphaComponent(0.4).cgColor
        self.contentView.addSubview(nameLabel)
        self.configureNameLabel()
    }
    
    func configureNameLabel() {
        nameLabel.textColor = UIConstants.notSelectedColor
        nameLabel.font = .systemFont(ofSize: UIConstants.labelSize)
        nameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.contentView)
        }
    }
}
