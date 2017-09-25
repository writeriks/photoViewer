//
//  ApiManager.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 23/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import Foundation

class APIManager {

    func loadData(_ urlString:String, completion:@escaping ([Author]) -> Void){
        
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        let url = URL(string: urlString)!  

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
        
            if error != nil {
                
                print(error!.localizedDescription)
                
                
            }else{
                do{
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONArray{

                        
                        var author = [Author]()
                        
                        for (index, entry) in json.enumerated(){

                            let entry = Author(data: entry as! JSONDictionary)
                            entry.vIndices = index + 1
                            author.append(entry)
                        }
                        
                        DispatchQueue.global(qos:DispatchQoS.QoSClass.default).async {
                            DispatchQueue.main.async{
                                completion(author)
                            }
                        }
                    }
                    
                }catch{
                    print("error in Json Serialization")
                }
            }
        })
        task.resume()
    }
    
}
