import UIKit
import SnapKit


class PromotionCollectionViewCell: UICollectionViewCell, ImageLoader {
    
    private var imageURL: String?
    var errorHandler: ((_ errorMessage: String) -> Void)?
    var gradient = CAGradientLayer()
    let imageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(_ imageURL: String) {
        guard self.imageURL == nil else { return }
        self.imageURL = imageURL
        
        self.loadImage(imageURL) { [weak self] image, error in
            if let error = error {
                self?.errorHandler?(error.localizedDescription)
                return
            }
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.removeShimmer()
            }
        }
    }
}


extension PromotionCollectionViewCell: SkeletonLoadable {
    func showLoadingAnimation() {
        setShimmer(layer: self.contentView.layer, frame: self.bounds)
    }
}


private extension PromotionCollectionViewCell {
    
    enum UIConstants {
        static let cornerRadius: CGFloat = 12.0
    }
    
    //MARK: - Private setup view
    func setupView() {
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = UIConstants.cornerRadius
        self.contentView.addSubview(imageView)
        self.configureImageView()
    }
    
    func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
    }
}
