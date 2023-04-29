import UIKit
import SnapKit

class LocationView: UIView {
    
    let cityLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelSize, weight: .medium)
        label.textColor = UIColor(named: Constants.Colors.Custom.darkMain)
        return label
    }()

    
    func configure(_ cityName:String) {
        cityLabel.text = cityName
        self.setupView()
    }
}



private extension LocationView {
    
    enum UIConstants {
        static let labelSize: CGFloat = 17.0
        static let leftOffset: CGFloat = 5.0
    }
    
    func setupView() {
        let imageView: UIImageView = {
           let view = UIImageView()
            view.image = UIImage(systemName: Constants.Images.System.chevronDown,
                                 withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
            view.tintColor = UIColor(named: Constants.Colors.Custom.darkImage)
            return view
        }()
        
        self.addSubview(cityLabel)
        self.addSubview(imageView)
        
        cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(UIConstants.leftOffset)
        }
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(cityLabel.snp.trailing).offset(UIConstants.leftOffset)
        }
    }
}
