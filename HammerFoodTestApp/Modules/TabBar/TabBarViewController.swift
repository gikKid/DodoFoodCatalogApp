import UIKit

class TabBarViewController: UITabBarController {

    let submodules: TabBarRouter.Submodules
    
    private enum UIConstants {
        static let borderWidth: CGFloat = 1.0
    }
    
    init(_ submodules: TabBarRouter.Submodules) {
        self.submodules = submodules
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        tabBar.tintColor = UIColor(named: Constants.Colors.Custom.main)
        tabBar.unselectedItemTintColor = UIColor(named: Constants.Colors.Custom.unselectTabItem)
        tabBar.layer.borderWidth = UIConstants.borderWidth
        tabBar.layer.borderColor = UIColor.systemGray4.cgColor
        
        self.viewControllers = [submodules.menu, submodules.contacts, submodules.profile, submodules.cart]
    }
}
