import UIKit

class CartModuleBuilder {
    static func build() -> UINavigationController {
        let cartViewController = CartViewController()
        return UINavigationController(rootViewController: cartViewController)
    }
}
