//
//  BaseRequestManager.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Alamofire

class BaseRequestManager {
    class func request(_ type: Service.type, method: HTTPMethod, completion: @escaping(Data?, String?) -> Void) {
        guard let url = URL(string: type.url) else { return }
        AF.request(url, method: method).validate().responseData(completionHandler: { data in
            switch data.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        })
    }
    
    class func requestImage(_ type: Service.type, completion: @escaping() -> Void) {
        guard let url = URL(string: type.url) else { return }
        AF.request(url, method: .get).response(completionHandler: { data in
            let x = data
            completion()
        })
    }
}
