//
//  MapViewController.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 9/10/24.
//

import MapKit

class MapViewController: UIViewController {
    var latitude: Double?
    var longitude: Double?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let latitude = latitude, let longitude = longitude {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        }
        
        let closeButtonImage = UIImage(named: "closeButton")
        let tintedImage = closeButtonImage?.withRenderingMode(.alwaysTemplate)
        self.closeButton.setImage(tintedImage, for: .normal)
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            // Actualiza el color de tinte cuando cambie el modo de interfaz
            updateButtonTintColor()
        }
    
    func updateButtonTintColor() {
            if traitCollection.userInterfaceStyle == .dark {
                closeButton.tintColor = UIColor.white
            } else {
                closeButton.tintColor = UIColor.black
            }
        }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
