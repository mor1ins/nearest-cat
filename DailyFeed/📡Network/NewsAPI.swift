
import Foundation
import PromiseKit

enum NewsAPI {
    
    static var baseURL = URLComponents(string: "https://60b6a11a17d1dc0017b88227.mockapi.io/")
    
    //NewsAPI.org API Endpoints
    static var url: URL? {
        NewsAPI.baseURL?.path = "/cat"
        guard let url = NewsAPI.baseURL?.url else { return nil }
        return url
    }
    
    
    static func getNewsItems() -> Promise<Cats> {
        
        return Promise { seal in
            guard let feedURL = NewsAPI.url else { seal.reject(JSONDecodingError.unknownError); return }
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
