import Foundation


//MARK: - FoodElement
struct FoodElement: Decodable {
    var categories: [Category]
    var id: String
}


//MARK: - Category
struct Category: Decodable {
    let name: String
    let content: [Content]
}


//MARK: - Content
struct Content: Decodable {
    let name, description, imageurl, id: String
    let price: Int
}


//MARK: - PromotionElement
struct PromotionElement: Decodable {
    var imageurl: String
    let id: String
}


//MARK: - FoodResource
struct FoodResource:APIResource {
    typealias ModelType = FoodElement
    
    var methodPath: String = {
        return Constants.Links.Paths.food
    }()
}


//MARK: - PromotionResource
struct PromotionResource:APIResource {
    typealias ModelType = PromotionElement
    
    var methodPath: String = {
        return Constants.Links.Paths.promotions
    }()
}


//MARK: - CategorySnapshot
struct CategoryHeaderSnapshot {
    var categories: [Category]
    var selectedIndex: Int
}
