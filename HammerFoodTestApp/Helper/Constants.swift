import UIKit

enum Constants {
    
    enum Links {
        static let mockurl = "https://644af9564bdbc0cc3a88fd86.mockapi.io"
        
        enum Paths {
            static let food = "/food"
            static let promotions = "/promotions"
        }
    }
    
    enum Keys {
        static let gradientBackground = "backgroundColor"
    }
    
    enum Error {
        static let dataNetwork = "Failed to get data"
        static let parseNetwork = "Failed to parse data"
        static let networkConnection = "No network connection"
    }
    
    enum Identefiers {
        static let promotionCollectCell = "promotionCollectionCell"
        static let categoryCollectCell = "categoryCollectionCell"
        static let foodCollectCell = "foodCollectionCell"
        static let categoryCollectionHeaderView = "categoryCollectionHeaderView"
    }
    
    enum Titles {
        static let menu = "Меню"
        static let contacts = "Контакты"
        static let profile = "Профиль"
        static let cart = "Корзина"
        static let OK = "OK"
        static let error = "Error"
    }
    
    enum Images {
        
        enum Custom {
            static let cart = "cart"
            static let profile = "profile"
            static let menu = "menu"
            static let contacts = "contactsPin"
        }
        
        enum System {
            static let chevronDown = "chevron.down"
        }
        
    }
    
    enum Colors {
        
        static let gradientDarkGrey = UIColor(red: 239/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
        static let gradientLightGrey = UIColor(red: 201/255.0, green: 201/255.0, blue: 201/255.0, alpha: 1)
        
        enum Custom {
            static let backgroundViewColor = "backViewColor"
            static let main = "mainColor"
            static let unselectTabItem = "unselectTabItemColor"
            static let darkMain = "darkMainColor"
            static let darkImage = "darkImageColor"
            static let descriptionText = "descriptionTextColor"
        }
    }
}
