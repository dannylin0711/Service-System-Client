//
//  ErrorCode.swift
//  Instant Support
//
//  Created by Danny Lin on 2021/8/20.
//

import Foundation
import SwiftyJSON
import Alamofire


class ErrorCode: NSObject{
    let errorCodeName:String
    let machineType:Int
    let errorDescription:String
    let errorInstuction:String
    let viewCount:Int
    var additionalFilesArray: [AdditionalFile] = []
    
    init(data: Any){
        let dataDictionary = JSON(data).dictionaryValue
        if let errorCodeName = dataDictionary["code_name"]{
            self.errorCodeName = errorCodeName.stringValue
        }else{
            self.errorCodeName = ""
        }
        if let machineType = dataDictionary["machineType"]{
            self.machineType = Int(machineType.stringValue) ?? 0
        }else{
            self.machineType = 0
        }
        if let errorDescription = dataDictionary["description"]{
            self.errorDescription = errorDescription.stringValue
        }else{
            self.errorDescription = ""
        }
        if let errorInstuction = dataDictionary["instruction"]{
            self.errorInstuction = errorInstuction.stringValue
        }else{
            self.errorInstuction = ""
        }
        if let viewCount = dataDictionary["view_count"]{
            self.viewCount = Int(viewCount.stringValue) ?? 0
        }else{
            self.viewCount = 0
        }
        
        if let additionalFilesArray = dataDictionary["additional_file"]?.arrayObject{
            for additionalFile in additionalFilesArray{
                let tempAdditionalFile = AdditionalFile(data: additionalFile)
                self.additionalFilesArray.append(tempAdditionalFile)
            }
        }
    }
    
    
}

