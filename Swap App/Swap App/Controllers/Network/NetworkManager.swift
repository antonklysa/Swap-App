//
//  NetworkManager.swift
//  Swap App
//
//  Created by Anton Klysa on 6/7/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import AFNetworking
import Mantle

final class NetworkManager: NSObject {
    
    static let sharedInstance: NetworkManager = NetworkManager()
    private var manager = AFHTTPSessionManager(baseURL: URL(string: "http://swap.ozeapps.com/api/"))
    
    private struct RequestType {
        static let login = (urlString: "Sync/login", application_type: "SWP", did: UIDevice.current.identifierForVendor?.uuidString)
        static let swap = (urlString: "swap/", application_type: "SWP", did: UIDevice.current.identifierForVendor?.uuidString)
    }
    
    final func loginWith(name: String!, password: String!, success: @escaping (UserModel?) -> Void, failure: @escaping (Error?) -> Void) {
        let params: [String: Any?] = ["application_type": RequestType.login.application_type,
                                            "hostess_id": name,
                                            "hostess_pass": password,
                                            "did": RequestType.login.did]

        manager.post(RequestType.login.urlString, parameters: params, constructingBodyWith: { (multipartFormData) in
            let data: Data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
            multipartFormData.appendPart(withHeaders: nil, body: data)
        }, progress: nil, success: { (dataTask, response) in
            
            guard let user: UserModel = try? MTLJSONAdapter.model(of: UserModel.self, fromJSONDictionary: response as! [AnyHashable : Any]) as! UserModel else {
                return
            }
            user.host_id = name
            UserManager.sharedInstance.currentUser = user

            success(UserManager.sharedInstance.currentUser)
            
        }) { (dataTask, error) in
            failure(error)
        }
    }
    
    final func swapWith(success: @escaping ([Brand]?) -> Void, failure: @escaping (Error?) -> Void) {
        
        let report: [[String: Any?]] = CoredataManager.sharedInstance.getHistories()?.count == 0 ? [] : CoredataManager.parseToJSONArray(source: CoredataManager.sharedInstance.getHistories()!) as [[String : Any?]]
        
        let params: [String: Any?] = ["application_type": RequestType.swap.application_type,
                                      "hostess_id": UserManager.sharedInstance.currentUser?.host_id,
                                      "report": report,
                                      "did": RequestType.swap.did]
        
        manager.post(RequestType.swap.urlString, parameters: params, constructingBodyWith: { (multipartFormData) in
            let data: Data = try! JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
            multipartFormData.appendPart(withHeaders: nil, body: data)
        }, progress: nil, success: { (dataTask, response) in
            CoredataManager.sharedInstance.deleteHistories()
            success(CoredataManager.sharedInstance.createBrands(source: (response as! [String : Any?])["brands"] as! [[String : Any]]))
            
        }) { (dataTask, error) in
            failure(error)
        }
    }
    
}
