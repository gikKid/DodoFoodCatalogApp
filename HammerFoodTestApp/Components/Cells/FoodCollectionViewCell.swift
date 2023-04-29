import UIKit
import SnapKit


class FoodCollectionViewCell: UICollectionViewCell, ImageLoader {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Constants.Colors.Custom.darkMain)
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: UIConstants.nameLabelSize, weight: .bold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textColor = UIColor(named: Constants.Colors.Custom.descriptionText)
        label.font = .systemFont(ofSize: UIConstants.descriptionLabelSize)
        return label
    }()
    
    let priceButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = UIConstants.priceButtonCornerRadius
        button.layer.borderColor = UIColor(named: Constants.Colors.Custom.main)?.cgColor
        button.setTitleColor(UIColor(named: Constants.Colors.Custom.main), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstants.buttonPriceLabelSize)
        button.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.buttonPriceWidth)
            make.height.equalTo(UIConstants.buttonPriceHeight)
        }
        return button
    }()
    
    var gradient = CAGradientLayer()
    var errorHandler: ((_ errorMessage:String) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure(_ foodContent: Content) {
        self.nameLabel.text = foodContent.name
        self.descriptionLabel.text = foodContent.description
        self.priceButton.setTitle("От \(foodContent.price) р", for: .normal)
        
        self.roundCorners(corners: [.topLeft,.topRight], radius: 0) // reset rounded top corners after first cell
        self.imageView.image = nil
        
        self.loadImage(foodContent.imageurl) { [weak self] image, error in
            if let error = error {
                self?.errorHandler?(error.localizedDescription)
                return
            }
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        priceButton.layer.borderWidth = UIConstants.priceButtonBorderWidth
        self.removeShimmer()
    }
}

extension FoodCollectionViewCell: SkeletonLoadable {
    func showLoadingAnimation() {
        self.setShimmer(layer: imageView.layer, frame: imageView.bounds)
    }
}



private extension FoodCollectionViewCell {
    
    enum UIConstants {
        static let nameLabelSize: CGFloat = 17.0
        static let descriptionLabelSize: CGFloat = 13.0
        static let buttonPriceLabelSize: CGFloat = 13.0
        static let priceButtonCornerRadius: CGFloat = 8.0
        static let priceButtonBorderWidth: CGFloat = 1.0
        static let dividerViewHeight: CGFloat = 1.0
        static let buttonPriceWidth: CGFloat = 87.0
        static let buttonPriceHeight: CGFloat = 32.0
        static let imageWidthOffset: CGFloat = 50.0
        static let spaceBtwText: CGFloat = 10.0
        static let imageRightOffset: CGFloat = 20.0
        static let rightOffset: CGFloat = 20.0
        static let leftOffset: CGFloat = 15.0
        static let topOffset: CGFloat = 20.0
    }
    
    
    //MARK: - Private setup view
    func setupView() {
        self.backgroundColor = .white
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo( (self.contentView.frame.width - UIConstants.imageWidthOffset) / 2)
        }
        
        let yTextStack = UIStackView()
        let yStack = UIStackView()
        let xStack = UIStackView()
        
        yTextStack.axis = .vertical
        yTextStack.alignment = .leading
        yTextStack.spacing = UIConstants.spaceBtwText
        yTextStack.addArrangedSubview(nameLabel)
        yTextStack.addArrangedSubview(descriptionLabel)
        
        yStack.axis = .vertical
        yStack.alignment = .trailing
        yStack.distribution = .equalSpacing
        yStack.spacing = UIConstants.spaceBtwText
        yStack.addArrangedSubview(yTextStack)
        yStack.addArrangedSubview(priceButton)
        
        xStack.axis = .horizontal
        xStack.distribution = .equalSpacing
        xStack.addArrangedSubview(imageView)
        xStack.addArrangedSubview(yStack)
        
        
        self.contentView.addSubview(xStack)
        
        xStack.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(UIConstants.topOffset)
            make.bottom.equalTo(self.contentView).offset(-UIConstants.topOffset)
            make.leading.equalTo(self.contentView).offset(UIConstants.leftOffset)
            make.trailing.equalTo(self.contentView).offset(-UIConstants.rightOffset)
        }
    }
}
