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
        
        let url = URL(string: urlString)!  // url i al

        let task = session.dataTask(with: url, completionHandler: { // url ile task oluştur içinde data, response ve error olsun
            (data, response, error) -> Void in
        
            if error != nil {
                
                print(error!.localizedDescription)
                
                
            }else{
                do{
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONArray{
                        print(json)
                        
                        var author = [Author]()
                        
                        for (_, entry) in json.enumerated(){
                            print(entry)
                            let entry = Author(data: entry as! JSONDictionary)// Videos class ındaki init metodunun içine etryleri atıp entrynin içine attı
                            
                            author.append(entry)
                        }
                        let i = author.count
                        print("Author Api Manager - total count ----> \(i)")
                        print("")
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
