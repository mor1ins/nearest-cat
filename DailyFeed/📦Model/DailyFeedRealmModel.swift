import Foundation
import RealmSwift


final class DailyFeedRealmModel: Object {
        
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var catDescription: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var latitude: Float64 = 0.0
    @objc dynamic var longitude: Float64 = 0.0


    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func toDailyFeedRealmModel(from: DailyFeedModel) -> DailyFeedRealmModel {
        let item = DailyFeedRealmModel()
        item.id = from.id
        
        if let name = from.name {
            item.name = name
        }
        
        if let writer = from.author {
            item.author = writer
        }
        
        if let latitude = from.latitude {
            item.latitude = latitude
        }

        if let longitude = from.longitude {
            item.longitude = longitude
        }

        if let catDescription = from.catDescription {
            item.catDescription = catDescription
        }
        
        if let image = from.image {
            item.image = image
        }
        
//        if let url = from.url {
//            item.url = url
//        }
        
        return item
    }
}
