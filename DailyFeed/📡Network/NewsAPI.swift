//
//  NewsAPI.swift
//  DailyFeed
//
//  Created by Sumit Paul on 13/01/17.
//

import Foundation
import PromiseKit

enum NewsAPI {
    
    case articles(source: String)
    case sources(category: String?, language: String?, country: String?)
    case search(query: String)
    
    static var baseURL = URLComponents(string: "https://60b6a11a17d1dc0017b88227.mockapi.io/")
//    static let apiToken = "8e58842e74f2453bb5e6e3845b386a81"
    
    //NewsAPI.org API Endpoints
    var url: URL? {
        switch self {
        case .articles(let source):
            let lSource = source
            NewsAPI.baseURL?.path = "/cat"
            guard let url = NewsAPI.baseURL?.url else { return nil }
            return url
            
        case .sources(let category, let language, let country):
            NewsAPI.baseURL?.path = "/v2/sources"
//            NewsAPI.baseURL?.queryItems = [URLQueryItem(name: "category", value: category),
//                                           URLQueryItem(name: "language", value: language),
//                                           URLQueryItem(name: "country", value: country),
//                                           URLQueryItem(name: "apiKey", value: NewsAPI.apiToken)]
            guard let url = NewsAPI.baseURL?.url else { return nil }
            return url
            
        case .search(let query):
            NewsAPI.baseURL?.path = "/v2/everything"
//            NewsAPI.baseURL?.queryItems = [URLQueryItem(name: "q", value: query),
//                                           URLQueryItem(name: "apiKey", value: NewsAPI.apiToken)]
            guard let url = NewsAPI.baseURL?.url else { return nil }
            return url
        }
    }

    static func getSourceNewsLogoUrl(source: String) -> String {
        let sourceLogoUrl = "https://res.cloudinary.com/news-logos/image/upload/v1557987666/\(source).png"
        return sourceLogoUrl
    }
    
    
    static func getNewsItems(source: String) -> Promise<Cats> {
        
        return Promise { seal in
            guard let feedURL = NewsAPI.articles(source: source).url else { seal.reject(JSONDecodingError.unknownError); return }
            let baseUrlRequest = URLRequest(url: feedURL)
            let session = URLSession.shared
        
            session.dataTask(with: baseUrlRequest) { (data, response, error) in
                
                guard error == nil else { seal.reject(error!); return }
                
                guard let data = data else { seal.reject(error!); return }
                
                do {
                    let jsonFromData =  try JSONDecoder().decode(Cats.self, from: data)
                    seal.fulfill(jsonFromData)
                } catch DecodingError.dataCorrupted(let context) {
                    seal.reject(DecodingError.dataCorrupted(context))
                } catch DecodingError.keyNotFound(let key, let context) {
                    print(key)
                    print(context)
                    seal.reject(DecodingError.keyNotFound(key, context))
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("error")
                    print(context)
                    seal.reject(DecodingError.typeMismatch(type, context))
                } catch DecodingError.valueNotFound(let value, let context) {
                    seal.reject(DecodingError.valueNotFound(value, context))
                } catch {
                    seal.reject(JSONDecodingError.unknownError)
                }
            }.resume()
        }
    }
}
