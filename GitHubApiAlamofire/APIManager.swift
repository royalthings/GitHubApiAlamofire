//
//  APIManager.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 5/1/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import Foundation
import Alamofire

typealias Closure = (_ response: Any?, _ error: Error?) -> Void

class APIManager {

    struct Path {

        static let supplementation: String = "users/"
    }

    static let shared = APIManager()

    fileprivate let baseURL: String = "https://api.github.com/"

    fileprivate var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]

    fileprivate init() {

    }

    // MARK: - performRequest

    fileprivate func performRequest(_ path: String, method: HTTPMethod = .get, parameters: Parameters = [:], _ completion: @escaping Closure) {
        let url = baseURL + path
        let utilityQueue = DispatchQueue.global(qos: .utility)
        Alamofire.request(url, method: method,parameters: parameters, headers: headers).responseJSON(queue: utilityQueue) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    completion(response.result.value, nil)
                }
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }

    // MARK: - get users

    func users(repositories: String, completion: @escaping Closure) {
        let parameters = ["repo": repositories]
        performRequest(repositories, method: .get, parameters: parameters, completion)
    }
}
