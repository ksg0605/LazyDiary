//
//  ViewController.swift
//  LazyDiary
//
//  Created by 김선규 on 12/18/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    
    let mapView: MKMapView = {
       let map = MKMapView()
        // 테마 설정
        map.overrideUserInterfaceStyle = .dark
        map.preferredConfiguration.elevationStyle = .flat
        map.setCenter(<#T##coordinate: CLLocationCoordinate2D##CLLocationCoordinate2D#>, animated: <#T##Bool#>)
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupNavigationBar()
        setMapConstraints()
    }

    private func setupNavigationBar() {
        self.title = "지도"
    }
    
    func setMapConstraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
    }

}
