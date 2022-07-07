//
//  SeachRepository.swift
//  Test
//
//  Created by cmc on 07/07/2022.
//

import UIKit
import Alamofire

protocol SeachService {
    func search(keyword: String, page: Int, completion: @escaping (Result<SearchResult, Error>) -> Void)
}

class SeachRepository: SeachService {
    
    func search(keyword: String, page: Int, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        guard let url = URL(string: Constants.baseUrl) else {
            completion(.failure(NetworkError.wrongURL))
            return
        }
        let param: [String: Any] = [Constants.Params.search: keyword,
                     Constants.Params.type: Constants.Params.movie,
                     Constants.Params.page: page]
        AF.request(url, method: .get, parameters: param).responseData { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    completion(.success(result))
                }
                catch let error {
                    completion(.failure(NetworkError.parser(error: error)))
                }
            }
        }
    }
}
enum NetworkError: Error {
    case wrongURL
    case parser(error: Error)
}
