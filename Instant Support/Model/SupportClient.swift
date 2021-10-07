//
//  SupportClient.swift
//  Instant Support
//
//  Created by Danny Lin on 2021/8/20.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

struct Config {
    static let acceptLanguage: String = "zh-TW,zh;q=0.8,en-US;q=0.6"
}
let TIMEOUT_INTERVAL: TimeInterval = 10

class SupportClient: NSObject{
    static let sharedClient = SupportClient()
    let standardUserDefaults = UserDefaults.standard
    var alamofireManager: Alamofire.SessionManager!
    
    fileprivate override init() {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["Accept-Language"] = Config.acceptLanguage
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TIMEOUT_INTERVAL
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getMachine(_ sender:NSObject, machineType:String){
        let parameters = ["machine":machineType]
        alamofireManager.request(String(format: GET_MACHINE_API, ENDPOINT),method: .get, parameters: parameters).validate().responseJSON { response in
            if response.result.isSuccess {

                let json = try! JSON(data: response.data!)
                //print(json)
                if let data = json.arrayObject?.first {
                    print(data)
                    if sender.responds(to: #selector(SupportHttpProtocol.appDidGetMachineInfo(_:))) {
                        sender.perform(#selector(SupportHttpProtocol.appDidGetMachineInfo(_:)), with: data)
                    }
                }
            }
        }
        
    }
}


@objc protocol SupportHttpProtocol : AnyObject {
    @objc optional func appDidGetMachineInfo(_ data: AnyObject)
}
