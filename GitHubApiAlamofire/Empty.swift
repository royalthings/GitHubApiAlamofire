//
//  Empty.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/26/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import Foundation
import Alamofire

typealias Closure = (_ response: Any?, _ error: Error?) -> Void

typealias JSON = Parameters

class APIManager {
    
    struct Path {
        
        static let environments: String = "method"
    }
    
    static let shared = APIManager()
    
    fileprivate let baseURL: String = "https://blablabla.com/"
    
    fileprivate var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    fileprivate init() {
        
    }
    
    // MARK: -
    
    fileprivate func performRequest(_ path: String, method: HTTPMethod = .get, parameters: Parameters = [:], encoding: ParameterEncoding = URLEncoding.default, _ completion: @escaping Closure) {
        let url = baseURL + path
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success:
                completion(response.result.value, nil)
            case .failure(let error):
                //print(self.handleError(error))
                completion(nil, error)
            }
        }
    }
    
    // MARK: -
    
    func method(forRepository repository: String, completion: @escaping Closure) {
        let parameters = ["repo": repository]
        performRequest(Path.environments, method: .post, parameters: parameters, encoding: JSONEncoding.default, completion)
    }
}
