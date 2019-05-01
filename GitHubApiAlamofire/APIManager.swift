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

        static var environments: String = ""
    }

    static let shared = APIManager()

    fileprivate let baseURL: String = "https://api.github.com/users/"

    fileprivate var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]

    fileprivate init() {

    }

    // MARK: - performRequest

    fileprivate func performRequest(_ path: String, method: HTTPMethod = .get, parameters: Parameters = [:], _ completion: @escaping Closure) {
        let url = baseURL + path
        Alamofire.request(url, method: method,parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completion(response.result.value, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }

    // MARK: - method

    func method(forRepository repository: String, completion: @escaping Closure) {
        let parameters = ["repo": repository]
        performRequest(Path.environments, method: .get, parameters: parameters, completion)
    }
}
