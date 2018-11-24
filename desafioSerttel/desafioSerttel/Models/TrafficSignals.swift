//
//  TrafficSignals.swift
//  desafioSerttel
//
//  Created by Felipe Figueirôa on 23/11/18.
//  Copyright © 2018 Felipe Figueirôa. All rights reserved.
//

import Foundation

class TrafficSignal {
    
    var utilizacao: String = ""
    var localizacao1: String = ""
    var localizacao2: String = ""
    var funcionamento: String = ""
    var sinalSonoro: String = ""
    var semaforo: String = ""
    var sinalizadorCiclista: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var id: Double = 0
    
    init(_ utilizacao: String, _ localizacao1: String, _ localizacao2: String, _ funcionamento: String, _ sinalSonoro: String, _ semaforo: String, _ sinalizadorCiclista: String, _  latitude: Double, _ longitude: Double, _ id: Int) {
        
        self.utilizacao = utilizacao
        self.localizacao1 = localizacao1
        self.localizacao2 = localizacao2
        self.funcionamento = funcionamento
        self.sinalSonoro = sinalSonoro
        self.semaforo = semaforo
        self.sinalizadorCiclista = sinalizadorCiclista
        self.latitude = latitude
        self.longitude = longitude
        self.id = id
    }
    
    
}
