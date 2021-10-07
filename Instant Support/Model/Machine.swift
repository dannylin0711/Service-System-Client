//
//  Machine.swift
//  Instant Support
//
//  Created by Danny Lin on 2021/8/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class Machine: NSObject{
    var errorCodeArray: [ErrorCode] = []
    let machineType: String
    let machineDescription: String
    let machineViewCount: Int
    
    init(data: Any){
        let dataDictionary = JSON(data).dictionaryValue
        if let machineType = dataDictionary["machine_type"]{
            self.machineType = machineType.stringValue
        }else{
            self.machineType = ""
        }
        if let machineDescription = dataDictionary["machine_description"]{
            self.machineDescription = machineDescription.stringValue
        }else{
            self.machineDescription = ""
        }
        if let machineViewCount = dataDictionary["view_count"]{
            self.machineViewCount = Int(machineViewCount.stringValue) ?? 0
        }else{
            self.machineViewCount = 0
        }
        if let errorCodeArray = dataDictionary["error_codes"]?.arrayObject{
            for errorCode in errorCodeArray{
                let tempErrorCode = ErrorCode(data: errorCode)
                self.errorCodeArray.append(tempErrorCode)
            }
        }
    }
}
