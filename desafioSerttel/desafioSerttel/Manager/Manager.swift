//
//  Manager.swift
//  desafioSerttel
//
//  Created by Felipe Figueirôa on 23/11/18.
//  Copyright © 2018 Felipe Figueirôa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


//ESTA CLASSE FAZ AS REQUISIÇÃO DA API, COLETANDO O JSON, E PASSANDO PARA A VIEWMODEL

class Manager {
    
    let apiURL = "http://desafio.serttel.com.br/dadosRecifeSemaforo.json"

    //let sharedInstance: Manager = Manager()
    private let manager: Alamofire.SessionManager!
    
    init() {
        let configutation = URLSessionConfiguration.default
        self.manager = Alamofire.SessionManager(configuration: configutation)
    }
    
    
    
    func request(_ method: Alamofire.HTTPMethod,
                 _ completion: @escaping ((_ response: [TrafficSignal], _ error: Any) -> Void)){
        
        let enconding: ParameterEncoding = JSONEncoding.default
        
        
        self.manager.request(self.apiURL).responseJSON { (response) in
            if response.result.error != nil{
                completion( [], "Error:" + response.description)
            }else {
                if let jsonObjct = response.result.value {
                    
                    var recordsArray: [TrafficSignal] = []
                    //var recordsObjct: TrafficSignal? = nil
                    
                    let json = JSON(jsonObjct)
                    //let records = json["records"]
                    
                    for (index,subJson):(String, JSON) in json["records"] {
                        
                        var recordObjcts = TrafficSignal(subJson["utlizacao"].stringValue, subJson["localizacao1"].stringValue, subJson["localizacao2"].stringValue, subJson["funcionamento"].stringValue, subJson["sinalSonoro"].stringValue, subJson["semaforo"].stringValue, subJson["sinalizadorCiclista"].stringValue, subJson["latitude"].doubleValue, subJson["longitude"].doubleValue, subJson["_id"].doubleValue)
                        
                        recordsArray.append(recordObjcts)
                        
                    }
                    
                    completion(recordsArray, "")
                    
                    
                }
            }
        }
        
    }
    
    
}
