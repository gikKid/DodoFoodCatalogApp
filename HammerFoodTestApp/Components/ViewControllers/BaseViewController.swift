import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configure()
        layoutViews()
    }
    
    func createInfoAlert(message:String, title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Titles.OK, style: .default, handler: nil))
        return alert
    }
}

@objc extension BaseViewController {
    func addViews() {}
    func configure() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(named: Constants.Colors.Custom.backgroundViewColor)
    }
    func layoutViews() {}
}
