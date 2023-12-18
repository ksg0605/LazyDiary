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
    
    
    private let mapView: MKMapView = {
       let map = MKMapView()
        // 테마 설정
        map.overrideUserInterfaceStyle = .dark
        // 지도에 내 위치 표시
        map.showsUserLocation = true
        // 현재 내 위치 기준으로 지도 움직이기
        map.setUserTrackingMode(.follow, animated: true)
        return map
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        setupNavigationBar()
        setMapConstraints()
        
        
    }
    
    // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인
    func checkUserDeviceLocationServiceAuthorization() {
        
        guard CLLocationManager.locationServicesEnabled() else {
//            시스템 설정으로 유도하는 커스텀 얼럿
            showRequestLocationServiceAlert()
            return
        }
        // 사용자 디바이스의 위치 서비스가 활성화 상태라면, 앱에 대한 권한 상태를 확인
        let authorizationStatus: CLAuthorizationStatus = locationManager.authorizationStatus
//        권한 상태값에 따라 분기처리를 수행하는 메서드
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                // 권한 요청을 보낸다.
                locationManager.requestWhenInUseAuthorization()
            
            case .denied, .restricted:
                // 사용자가 권한을 거부, 위치 서비스 활성화 제한 상태
                // 시스템 설정에서 설정값을 변경하도록 유도
                // 시스템 설정으로 이동
                showRequestLocationServiceAlert()
            
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                
            default:
                print("default")
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(
            title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .default) { [weak self] _ in
//                async { await self?.reloadData() }
        }
        
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
            
        present(requestLocationServiceAlert, animated: true)
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

extension ViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 효과적으로 가져왔을 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            // 사용자 위치 정보 사용
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 가져오지 못했을 때
    func locationManger(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 앱에 대한 권한 설정이 변경되면 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkUserDeviceLocationServiceAuthorization()
    }
}
