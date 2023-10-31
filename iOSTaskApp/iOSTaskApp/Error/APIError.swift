//
//  APIError.swift
//  iOSTaskApp
//
//  Created by Saravanan R on 26/10/23.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}


protocol APIServiceProtocol {
    func fetchNewsData( complete: @escaping ( _ success: Bool, _ articles: [Article], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    
    func fetchNewsData( complete: @escaping ( _ success: Bool, _ articles: [Article], _ error: APIError? )->() ) {
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "Contents", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let news = try! decoder.decode(NewsModel.self, from: data)
            complete( true, news.articles, nil )
        }
    }
}
