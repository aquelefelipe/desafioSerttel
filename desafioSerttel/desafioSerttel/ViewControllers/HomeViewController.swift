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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //LATITUDE E LONGITUDE DE RECIFE
        let camera = GMSCameraPosition.camera(withLatitude: -8.05428, longitude: -34.8813, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        mapView.delegate = self
        print("Traffic Signal")
        homeView.getTrafficSignals()
        print("Add Markers")
        addMarketsinMap(homeView, mapView)
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Mapa"
    }
    
    func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue?.identifier == "detailsSegue" {
            if let nextViewController = segue?.destination as? DetailsViewController {
                
            }
        }
        
    }
    
    func addMarketsinMap(_ hView: HomeViewModel, _ mapView: GMSMapView) {
//        for index in 1...hv.qtd {
//
//            let identifier: Double = hv.getId(index: index)
//
//            let position = CLLocationCoordinate2D(latitude: hv.getLatitude(index: index), longitude: hv.getLongitude(index: index))
//            let marker = GMSMarker(position: position)
//            marker.title = hv.getlocalizacao1(index: index)
//            marker.userData = identifier
//            marker.map = mapView
//        }
        
        print(hView.semaforosArray)
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
    
    // tap map marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let alert = UIAlertController(title: "More Informations", message: "Gostaria de saber mais informações?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler:{ (_) in
          self.performSegue(withIdentifier: "datailsSegue", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "no", style: .cancel, handler:{ (_) in
            //self.homeView.recieveDatas()
        } ))
        
        self.present(alert, animated: true)

        // tap event handled by delegate
        return true
    }
    
    
    
    
    
}
