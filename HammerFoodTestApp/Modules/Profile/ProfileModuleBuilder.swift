import UIKit

class ProfileModuleBuilder {
    static func build() -> UINavigationController {
        let profileViewController = ProfileViewController()
        return UINavigationController(rootViewController: profileViewController)
    }
}
