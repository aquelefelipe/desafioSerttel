//
//  HomeViewController.swift
//  desafioSerttel
//
//  Created by Felipe Figueirôa on 23/11/18.
//  Copyright © 2018 Felipe Figueirôa. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {

    let homeView = HomeViewModel()
    var signalsArray: [TrafficSignal]?
    var tapedPin: TrafficSignal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //LATITUDE E LONGITUDE DE RECIFE
        let camera = GMSCameraPosition.camera(withLatitude: -8.05428, longitude: -34.8813, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        mapView.delegate = self
        
        
        
        self.homeView.getTrafficSignals {
            print(self.homeView.semaforosArray)
            self.addMarketsinMap(self.homeView, mapView)
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func addMarketsinMap(_ signals: HomeViewModel, _ mapView: GMSMapView) {
    
        for index in 1...signals.semaforosArray.count - 1 {
            let position = CLLocationCoordinate2D(latitude: signals.getLatitude(index: index), longitude: signals.getLongitude(index: index))
            print("LATITUDE: \(signals.getLongitude(index: index))")
            let marker = GMSMarker(position: position)
            marker.title = signals.semaforosArray[index].localizacao1
            marker.userData = signals.semaforosArray[index]
            marker.map = mapView
        }
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Mapa"
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

extension HomeViewController: GMSMapViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datailsSegue" {
            
            if let nextViewController: DetailsViewController = segue.destination as? DetailsViewController {
                
                print("TO PRINTANDO AQUII: \(String(describing: self.homeView.semaforosArray[23].id))")
                nextViewController.markerPin = self.tapedPin
                
                
                //                nextViewController.localizacao.text = nextViewController.localizacao.text! + " " + (self.tapedPin?.localizacao1)!
                //                nextViewController.referencia.text = nextViewController.referencia.text! + " " + (self.tapedPin?.localizacao2)!
                //                nextViewController.utilizacao.text = nextViewController.utilizacao.text! + " " + (self.tapedPin?.utilizacao)!
                //                nextViewController.sinalSonoro.text = nextViewController.sinalSonoro.text! + " " + (self.tapedPin?.sinalSonoro)!
                //                nextViewController.semaforo.text = nextViewController.semaforo.text! + " " + (self.tapedPin?.semaforo)!
                //                nextViewController.sinalCiclista.text = nextViewController.sinalCiclista.text! + " " + (self.tapedPin?.sinalizadorCiclista)!
                //                nextViewController.latitude.text = nextViewController.latitude.text! + " " + String(format: "%f", (self.tapedPin?.latitude)!)
                //                nextViewController.longitude.text = nextViewController.longitude.text! + " " + String(format: "%f", (self.tapedPin?.longitude)!)
                
            }
        }
    }

    
    
    //CRIAR O POP UP AQUI PARA DAR AS OPCAO DE MOSTRAR MAIS INFORMAÇÕES
    
    // tap map marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        self.tapedPin = marker.userData as? TrafficSignal
        
        let alert = UIAlertController(title: "Mais informações", message: "Gostaria de saber mais sonre o Pin?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ver detalhes", style: .default, handler:{ (_) in
            print("ID MARKER: \(self.tapedPin?.id)")
            print("ALGUMA COISA: \(self.homeView.semaforosArray[24])")
            self.performSegue(withIdentifier: "datailsSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler:{ (_) in
            print("ID MARKER: \(self.tapedPin?.id)")
        } ))
        
        self.present(alert, animated: true)

        // tap event handled by delegate
        return true
    }
    
    
    
    
    
}
