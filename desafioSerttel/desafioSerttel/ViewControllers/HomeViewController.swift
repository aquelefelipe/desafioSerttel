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
    
        //CARREGA O MAPA NO APLICATICO
        //COORDENADAS DA CIDADE DO RECIFE
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Mapa"
    }
    
    //ESTA FUNCÃO CARREGA NO MAPA TODOS OS MARKER QUE REPRESENTAM OS SEMAFOROS
    func addMarketsinMap(_ signals: HomeViewModel, _ mapView: GMSMapView) {
    
        for index in 1...signals.semaforosArray.count - 1 {
            let position = CLLocationCoordinate2D(latitude: signals.getLatitude(index: index), longitude: signals.getLongitude(index: index))
            let marker = GMSMarker(position: position)
            marker.title = signals.semaforosArray[index].localizacao1
            marker.userData = signals.semaforosArray[index]
            marker.map = mapView
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
