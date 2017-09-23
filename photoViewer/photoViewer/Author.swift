//
//  Author.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 23/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import Foundation

class Author{

    fileprivate var _vAuthor:String?
    fileprivate var _vFormat:String?
    fileprivate var _vFileName:String?
    fileprivate var _vWidth:Int?
    fileprivate var _vHeight:Int?
    fileprivate var _vID:Int?
    
    var vImageData:Data?
    
    var vAuthor: String{
        return _vAuthor!
    }
    var vFormat: String{
        return _vFormat!
    }
    var vFileName: String{
        return _vFileName!
    }
    var vWidth: Int{
        return _vWidth!
    }
    var vHeight: Int{
        return _vHeight!
    }
    var vID: Int{
        return _vID!
    }
    
    init(data:JSONDictionary){
    
        if let author = data["author"] as? String{
            self._vAuthor = author
        }else{
            self._vAuthor = ""
        }
        if let format = data["format"] as? String{
            self._vFormat = format
        }else{
            self._vFormat = ""
        }
        if let filename = data["filename"] as? String{
            self._vFileName = filename
        }else{
            self._vFileName = ""
        }
        if let width = data["width"] as? Int{
            self._vWidth = width
        }else{
            self._vWidth = nil
        }
        if let height = data["height"] as? Int{
            self._vHeight = height
        }else{
            self._vHeight = nil
        }
        if let Id = data["id"] as? Int{
            self._vID = Id
        }else{
            self._vID = nil
        }
    }
}
