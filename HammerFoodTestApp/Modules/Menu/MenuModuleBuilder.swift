import UIKit

class MenuModuleBuilder {
    static func build() -> UINavigationController {
        let menuViewController = MenuViewController()
        
        let presenter: (ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol) = MenuPresenter()
        
        menuViewController.presenter = presenter
        menuViewController.presenter?.view = menuViewController
        menuViewController.presenter?.interactor = MenuInteractor()
        menuViewController.presenter?.interactor?.presenter = presenter
        menuViewController.presenter?.router = MenuRouter()
        
        return UINavigationController(rootViewController: menuViewController)
    }
}
