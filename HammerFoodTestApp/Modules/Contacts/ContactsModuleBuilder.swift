import UIKit

class ContactsModuleBuilder {
    static func build() -> UINavigationController {
        let contactsViewController = ContactsViewController()
        return UINavigationController(rootViewController: contactsViewController)
    }
}
