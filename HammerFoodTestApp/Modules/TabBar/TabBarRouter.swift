import UIKit

class TabBarRouter {
    
    typealias Submodules = (
        menu: UINavigationController,
        contacts: UINavigationController,
        profile: UINavigationController,
        cart: UINavigationController
    )
    
    static func configureTabs(_ submodules: Submodules) {
        
        let menuTabBarItem = UITabBarItem(title: Constants.Titles.menu,
                                          image: UIImage(named: Constants.Images.Custom.menu), tag: 0)
        
        let contactsTabBarItem = UITabBarItem(title: Constants.Titles.contacts,
                                              image: UIImage(named: Constants.Images.Custom.contacts), tag: 1)
        
        let profileTabBarItem = UITabBarItem(title: Constants.Titles.profile,
                                             image: UIImage(named: Constants.Images.Custom.profile), tag: 2)
        
        let cartTabBarItem = UITabBarItem(title: Constants.Titles.cart,
                                          image: UIImage(named: Constants.Images.Custom.cart), tag: 3)
        
        submodules.menu.tabBarItem = menuTabBarItem
        submodules.contacts.tabBarItem = contactsTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        submodules.cart.tabBarItem = cartTabBarItem
    }
}
