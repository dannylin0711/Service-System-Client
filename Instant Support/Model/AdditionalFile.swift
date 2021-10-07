//
//  AdditionalFile.swift
//  Instant Support
//
//  Created by Danny Lin on 2021/8/20.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

class AdditionalFile:NSObject{
    let filename:String
    let filepath:String
    let errorCode:Int
    
    init(data:Any){
        let dataDictionary = JSON(data).dictionaryValue
        if let filename = dataDictionary["file_name"]{
            self.filename = filename.stringValue
        }else{
            self.filename = ""
        }
        if let filepath = dataDictionary["file_path"]{
            self.filepath = filepath.stringValue
        }else{
            self.filepath = ""
        }
        if let errorCode = dataDictionary["error_code"]{
            self.errorCode = Int(errorCode.stringValue) ?? 0
        }else{
            self.errorCode = 0
        }
        
        
        
    }
    
    
}
