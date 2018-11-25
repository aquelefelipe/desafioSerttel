//
//  DetailsViewController.swift
//  desafioSerttel
//
//  Created by Felipe Figueirôa on 23/11/18.
//  Copyright © 2018 Felipe Figueirôa. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var localizacao: UILabel!
    @IBOutlet weak var referencia: UILabel!
    @IBOutlet weak var utilizacao: UILabel!
    @IBOutlet weak var funcionamento: UILabel!
    @IBOutlet weak var sinalSonoro: UILabel!
    @IBOutlet weak var semaforo: UILabel!
    @IBOutlet weak var sinalCiclista: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    
    var markerPin:TrafficSignal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localizacao.text = self.localizacao.text! + " " + (self.markerPin?.localizacao1)!
        self.referencia.text = self.referencia.text! + " " + (self.markerPin?.localizacao2)!
        self.utilizacao.text = self.utilizacao.text! + " " + (self.markerPin?.utilizacao)!
        self.funcionamento.text = self.funcionamento.text! + " " + (self.markerPin?.funcionamento)!
        self.sinalSonoro.text = self.sinalSonoro.text! + " " + (self.markerPin?.sinalSonoro)!
        self.semaforo.text = self.semaforo.text! + " " + (self.markerPin?.semaforo)!
        self.sinalCiclista.text = self.sinalCiclista.text! + " " + (self.markerPin?.sinalizadorCiclista)!
        self.latitude.text = self.latitude.text! + " " + String(format: "%f", (self.markerPin?.latitude)!)
        self.longitude.text = self.longitude.text! + " " + String(format: "%f", (self.markerPin?.longitude)!)
        
        print(self.markerPin?.utilizacao)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
