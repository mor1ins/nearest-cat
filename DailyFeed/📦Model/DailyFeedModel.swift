//
//  DailyFeedModel.swift
//  DailyFeed
//
//  Created by Sumit Paul on 27/12/16.
//

import Foundation
import MobileCoreServices

enum DailyFeedModelUTI {
    static let kUUTTypeDailyFeedModel = "kUUTTypeDailyFeedModel"
}

enum DailyFeedModelError: Error {
    case invalidTypeIdentifier
    case invalidDailyFeedModel
}

struct Cats: Codable {
    var cats: [DailyFeedModel]
}

//Data Model
final class DailyFeedModel: NSObject, Serializable {
    
    public var id: String = ""
    public var name: String?
    public var author: String?
    public var catDescription: String?
    public var image: String?
    public var latitude: Float64?
    public var longitude: Float64?
    
    private enum CodingKeys: String, CodingKey {
        case catDescription = "description"
        case id = "id"
        case name = "name"
        case author = "author"
        case image = "image"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

extension DailyFeedModel: NSItemProviderWriting {
    
    static var writableTypeIdentifiersForItemProvider: [String] = [DailyFeedModelUTI.kUUTTypeDailyFeedModel, kUTTypeUTF8PlainText as String]
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        if typeIdentifier == DailyFeedModelUTI.kUUTTypeDailyFeedModel {
            completionHandler(self.serialize(), nil)
        } else if typeIdentifier == kUTTypeUTF8PlainText as String {
//            completionHandler(self.url?.data(using: .utf8), nil)
        } else {
            completionHandler(nil, DailyFeedModelError.invalidDailyFeedModel)
        }
        return nil
    }
}

extension DailyFeedModel: NSItemProviderReading {
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [DailyFeedModelUTI.kUUTTypeDailyFeedModel]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> DailyFeedModel {
        if typeIdentifier == DailyFeedModelUTI.kUUTTypeDailyFeedModel {
            let dfm = DailyFeedModel()
            do {
                let dailyFeedModel = try dfm.deserialize(data: data)
                return dailyFeedModel
            } catch {
                throw DailyFeedModelError.invalidDailyFeedModel
            }
        } else {
            throw DailyFeedModelError.invalidTypeIdentifier
        }
    }
}

