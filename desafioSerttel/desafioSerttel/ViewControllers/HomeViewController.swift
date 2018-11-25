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
    var soundSignal: Bool = false
    var mapView: GMSMapView!
    @IBOutlet weak var bnt: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //CARREGA O MAPA NO APLICATICO
        //COORDENADAS DA CIDADE DO RECIFE
        let camera = GMSCameraPosition.camera(withLatitude: -8.05428, longitude: -34.8813, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        mapView.delegate = self
        
        self.homeView.getTrafficSignals {
            
            self.addMarketsinMap(self.homeView, self.mapView, self.soundSignal)
            
        }
        //self.bnt.titleLabel?.font = UIFont(name: "Filter", size: 20.0)
        self.view.addSubview(self.bnt)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Mapa"
    }
    
    //ESTA FUNCÃO CARREGA NO MAPA TODOS OS MARKER QUE REPRESENTAM OS SEMAFOROS OU APENAS AQUELES QUE POSSUEM SINAL SONOTO
    func addMarketsinMap(_ signals: HomeViewModel, _ mapView: GMSMapView, _ soundTrafficSignal: Bool) {
    
        mapView.clear()
        for index in 1...signals.semaforosArray.count - 1 {
            
            if soundTrafficSignal {
                
                if signals.semaforosArray[index].sinalSonoro == "S" {
                    
                    self.addMarker(signals, index, mapView)
                    
                }
                
            } else {
                
                
                self.addMarker(signals, index, mapView)
                
            }
            
            
        }
        
    }
    
    func addMarker( _ homeView: HomeViewModel, _ index: Int, _ mapView: GMSMapView) {
        
        let position = CLLocationCoordinate2D(latitude: homeView.getLatitude(index: index), longitude: homeView.getLongitude(index: index))
        let marker = GMSMarker(position: position)
        marker.title = homeView.semaforosArray[index].localizacao1
        marker.userData = homeView.semaforosArray[index]
        marker.map = mapView
        
    }
    
    @IBAction func changeMarkers(_ sender: Any) {
        if self.soundSignal == true{
            self.soundSignal = false
            self.addMarketsinMap(self.homeView, self.mapView, self.soundSignal)
        }else {
            self.soundSignal = true
            self.addMarketsinMap(self.homeView, self.mapView, self.soundSignal)
        }
    }
    
    
    
    //CARREGA AS INFORMAÇÕES QUE SERÃO PASSADAS PARA OUTRA TELA DE ACORDO COM O NOME DA SEGUE
    //PASSA AS INFORMAÇÕES DO MARKER QUE FOI CLICADO
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datailsSegue" {
            
            if let nextViewController: DetailsViewController = segue.destination as? DetailsViewController {
                
                nextViewController.markerPin = self.tapedPin
                
            }
        }
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
    
    //CRIAR O POP UP AQUI PARA DAR AS OPCAO DE MOSTRAR MAIS INFORMAÇÕES
    //AO CLICKAR NUM PIN AS INFORMAÇÕES DELE SÃO SALVOS NO tapedPin
    
    // tap map marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        self.tapedPin = marker.userData as? TrafficSignal
        
        let alert = UIAlertController(title: "Mais informações", message: "Gostaria de saber mais sobre o Pin \(String(format: "%.0f", (self.tapedPin?.id)!) )?" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ver detalhes", style: .default, handler:{ (_) in
            self.performSegue(withIdentifier: "datailsSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)

        // tap event handled by delegate
        return true
    }
    
    
    
    
    
}
