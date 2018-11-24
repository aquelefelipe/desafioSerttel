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

    let sharedInstance: Manager = Manager()
    private let manager: Alamofire.SessionManager!
    
    private init() {
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
                    var recordsObjct: TrafficSignal? = nil
                    
                    let json = JSON(jsonObjct)
                    //let records = json["records"]
                    
                    for (index,subJson):(String, JSON) in json["records"] {
                        recordsObjct?.utilizacao = subJson["utlizacao"].stringValue
                        recordsObjct?.localizacao1 = subJson["localizacao1"].stringValue
                        recordsObjct?.localizacao2 = subJson["localizacao2"].stringValue
                        recordsObjct?.funcionamento = subJson["funcionamento"].stringValue
                        recordsObjct?.sinalSonoro = subJson["sinalSonoro"].stringValue
                        recordsObjct?.semaforo = subJson["semaforo"].stringValue
                        recordsObjct?.sinalizadorCiclista = subJson["sinalizadorCiclista"].stringValue
                        recordsObjct?.latitude = subJson["latitude"].doubleValue
                        recordsObjct?.longitude = subJson["longitude"].doubleValue
                        recordsObjct?.id = subJson["_id"].doubleValue
                        
                        recordsArray.append(recordsObjct!)
                        
                    }
                    
                    completion(recordsArray, "")
                    
                    
                }
            }
        }
        
    }
    
    
}
