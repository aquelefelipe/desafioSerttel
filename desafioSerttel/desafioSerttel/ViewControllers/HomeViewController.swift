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

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //LATITUDE E LONGITUDE DE RECIFE
        let camera = GMSCameraPosition.camera(withLatitude: -8.05428, longitude: -34.8813, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        mapView.delegate = self
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -8.05428, longitude: -34.8813)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
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
        alert.addAction(UIAlertAction(title: "no", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
        print("didTap marker \(marker.title)")

        // remove color from currently selected marker
        if let selectedMarker = mapView.selectedMarker {
            selectedMarker.icon = GMSMarker.markerImage(with: nil)
        }

        // select new marker and make green
        mapView.selectedMarker = marker
        marker.icon = GMSMarker.markerImage(with: UIColor.green)

        // tap event handled by delegate
        return true
    }
    
    
    
    
    
}
