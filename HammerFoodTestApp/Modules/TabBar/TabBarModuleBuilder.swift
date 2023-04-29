import UIKit

class TabBarModuleBuilder {
    static func build(with submodules: TabBarRouter.Submodules) -> UIViewController {
        TabBarRouter.configureTabs(submodules)
        let tabBarController = TabBarViewController(submodules)
        return tabBarController
    }
}
