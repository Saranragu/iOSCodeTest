//
//  APIHandler.swift
//  iOSTaskApp
//
//  Created by Saravanan R on 26/10/23.
//

import Foundation
import Combine

protocol NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsModel, APIError>
}

struct NewsServiceCall : NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsModel, APIError> {
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown }
            .flatMap{ data, response -> AnyPublisher<NewsModel, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode){
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: NewsModel.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                }else{
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}



