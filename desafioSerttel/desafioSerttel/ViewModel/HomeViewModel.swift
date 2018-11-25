//
//  HomeViewModel.swift
//  desafioSerttel
//
//  Created by Felipe Figueirôa on 23/11/18.
//  Copyright © 2018 Felipe Figueirôa. All rights reserved.
//

import Foundation

//A VIEW MODEL TEM AS FUNÇÃO QUE TRABALHAM EM CIMA DOS VALORES PRESENTE NO MODEL, FAZ A REQUISIÇÃO DOS DADOS E GUARDA-OS NO MODEL

class HomeViewModel: NSObject {
    
    let manager = Manager()
    
    var semaforosArray: [TrafficSignal] = []
    var qtd: Int = 0
    
    
    
    func getTrafficSignals(_ completion: @escaping () -> Void ) {
        
        manager.request(.get) { (trafficSignal, erro) in
            print("localização1: \(trafficSignal[1].localizacao1) \n localização2: \(trafficSignal[1].localizacao2)\n Latitude: \(trafficSignal[1].latitude) ")
            self.semaforosArray.append(contentsOf: trafficSignal)
            completion()

        }
        
        
    }
    
    func getUtilizacao(index: Int) -> String {
        return semaforosArray[index].utilizacao
    }
    
    func getlocalizacao1(index: Int) -> String {
        return semaforosArray[index].localizacao1
    }
    
    func getlocalizacao2(index: Int) -> String {
        return semaforosArray[index].localizacao2
    }

    func getFuncionamento(index: Int) -> String {
         return semaforosArray[index].funcionamento
    }
    
    func getSinalSonoro(index: Int) -> String {
        return semaforosArray[index].sinalSonoro
    }
    func getSemaforo(index: Int) -> String {
        return semaforosArray[index].semaforo
    }
    
    func getSinalizadorCiclista(index: Int) -> String {
        return semaforosArray[index].sinalizadorCiclista
    }
    
    func getLatitude(index: Int) -> Double {
        return semaforosArray[index].latitude 
    }
    
    func getLongitude(index: Int) -> Double {
        return semaforosArray[index].longitude
    }
    
    func getId(index: Int) -> Double {
        return semaforosArray[index].latitude
    }

    
}
