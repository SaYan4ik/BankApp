//
//  BankLocationMapController.swift
//  BankMap
//
//  Created by Александр Янчик on 12.01.23.
//

import UIKit
import GoogleMaps
import CoreLocation


class BankLocationMapController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var atmBankCollectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    let locationManager = CLLocationManager()
    private var data = [BankModel]()
    private var filials = [FilialModel]()
    private var bankAtmType = BankType.allCases
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private var city: String = ""
    
    private var cityName = [String]() {
        didSet {
            cityName = Array(Set(cityName))
            cityName = cityName.sorted(by: {$0 < $1})
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getFilialInfo()
        getBankInfo()
        registrationCell()
        
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        atmBankCollectionView.dataSource = self
        atmBankCollectionView.delegate = self

        cityCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        atmBankCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        mapView.isMyLocationEnabled = true
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    @IBAction func myLocationButtonDidTap(_ sender: Any) {
        mapView.clear()
        guard let myPosition = locationManager.location?.coordinate else { return }
        drawCircle(lat: myPosition.latitude, long: myPosition.longitude)
        showAllBanksNear(lat: myPosition.latitude, long: myPosition.longitude)
        
        let camera = GMSCameraPosition(latitude: myPosition.latitude, longitude: myPosition.longitude, zoom: 8)
        mapView.animate(to: camera)
    }
    
    
    private func registrationCell() {
        let nib = UINib(nibName: BankCell.id, bundle: nil)
        atmBankCollectionView.register(nib, forCellWithReuseIdentifier: BankCell.id)
        
        let nibCity = UINib(nibName: CityCell.id, bundle: nil)
        cityCollectionView.register(nibCity, forCellWithReuseIdentifier: CityCell.id)
    }
    
    private func getBankInfo() {
        var city = [String]()
        spinner.startAnimating()
        GetBankInfo().getInfo(city: "") { banks in
            self.data = banks
            
            banks.forEach { bank in
                if bank.addressType == "г." {
                    city.append(bank.city)
                }
            }
            
            self.cityName.append(contentsOf: city)
            self.cityCollectionView.reloadData()
            self.spinner.startAnimating()
        }
    }
    
    private func getFilialInfo() {
        var city = [String]()
        
        spinner.startAnimating()
        GetBankInfo().getFilialInfo(city: "") { allFilials in
            self.filials = allFilials
            
            allFilials.forEach { filial in
                if filial.nameType == "г." {
                    guard let name = filial.name else { return }
                    city.append(name)
                }
            }
            self.cityName.append(contentsOf: city)
            self.cityCollectionView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    private func drawCircle(lat: Double, long: Double) {
        let circleCenter = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let circle = GMSCircle(position: circleCenter, radius: 5000)
        circle.strokeColor = .systemBlue.withAlphaComponent(0.6)
        circle.fillColor = .systemBlue.withAlphaComponent(0.2)
        circle.strokeWidth = 2
        circle.map = mapView
    }
    
    private func showAllBanksNear(lat: Double, long: Double) {
        let centreCoord = CLLocation(latitude: lat, longitude: long)
        
        data.forEach { atm in
            let coordAtm = CLLocation(latitude: Double(atm.gpsX) ?? 0.0, longitude: Double(atm.gpsY) ?? 0.0)
            let distance = coordAtm.distance(from: centreCoord)
            if distance <= 5000 {
                drawAtmMarkInRadius(atm: atm)
            }
        }
        
        filials.forEach { filial in
            guard let gpsX = filial.gpsX,
                  let gpsY = filial.gpsY
            else { return }
            
            let coordFilial = CLLocation(latitude: Double(gpsX) ?? 0.0, longitude: Double(gpsY) ?? 0.0)
            let distance = coordFilial.distance(from: centreCoord)
            if distance <= 5000 {
                drawFilialMarkInRadius(filial: filial)
            }
        }
        
    }
    
   

}

// MARK: -
// MARK: - DrawMArkersFunctions

extension BankLocationMapController {
    
    private func drawMarkForBank(bank: BankModel) {
        let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(bank.gpsX) ?? 0.0, longitude: Double(bank.gpsY) ?? 0.0))
        mark.map = mapView
        mark.title = bank.addressType + bank.address + bank.numHouse
        mark.snippet = " Время работы \(bank.warkTime)"
        mark.icon = GMSMarker.markerImage(with: .green.withAlphaComponent(0.5))
        let camera = GMSCameraPosition(latitude: Double(bank.gpsX) ?? 0.0, longitude: Double(bank.gpsY) ?? 0.0, zoom: 8)
        mapView.animate(to: camera)
        mapView.selectedMarker = mark
        mapView.selectedMarker = nil
    }
    
    private func drawMarkForFilial(filial: FilialModel) {
        guard let gpsX = filial.gpsX,
              let gpsY = filial.gpsY else { return }
        let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(gpsX) ?? 0.0, longitude: Double(gpsY) ?? 0.0))
        mark.map = mapView
        mark.title = "Филиал \(String(describing: filial.filialName))"
        mark.icon = GMSMarker.markerImage(with: .systemMint)
        let camera = GMSCameraPosition(latitude: Double(gpsX) ?? 0.0, longitude: Double(gpsY) ?? 0.0, zoom: 8)
        mapView.animate(to: camera)
        mapView.selectedMarker = mark
        mapView.selectedMarker = nil
    }
    
    
    private func drawMarkersForBankCity(city: String) {
        GetBankInfo().getInfo(city: city) { banks in
            banks.forEach { bank in
                self.drawMarkForBank(bank: bank)
            }
        }
    }
    
    private func drawMarkersForFilialCity(city: String) {
        GetBankInfo().getFilialInfo(city: city) { filials in
            filials.forEach { filial in
                self.drawMarkForFilial(filial: filial)
            }
        }
    }
    
    private func drawAtmMarkInRadius(atm: BankModel) {
        let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(atm.gpsX) ?? 0.0, longitude: Double(atm.gpsY) ?? 0.0))
        mark.map = mapView
        mark.title = atm.addressType + atm.address + atm.numHouse
        mark.snippet = " Время работы \(atm.warkTime)"
        mark.icon = GMSMarker.markerImage(with: .green.withAlphaComponent(0.5))
        mapView.selectedMarker = mark
        mapView.selectedMarker = nil
    }
    
    private func drawFilialMarkInRadius(filial: FilialModel) {
        guard let gpsX = filial.gpsX,
              let gpsY = filial.gpsY,
              let name = filial.filialName
        else { return }
        
        let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(gpsX) ?? 0.0, longitude: Double(gpsY) ?? 0.0))
        mark.map = mapView
        mark.title = "Филиал \(name))"
        mark.icon = GMSMarker.markerImage(with: .systemMint)
        mapView.selectedMarker = mark
        mapView.selectedMarker = nil
    }
    
}

// MARK: -
// MARK: - UICollectionViewDataSource

extension BankLocationMapController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cityName.count
        } else {
            return bankAtmType.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cityCollectionView {
            let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath)
            guard let cityCell = cell as? CityCell else { return cell }
            cityCell.set(name: cityName[indexPath.item])
            
            return cityCell
        } else {
            let cell = atmBankCollectionView.dequeueReusableCell(withReuseIdentifier: BankCell.id, for: indexPath)
            guard let atmBankCell = cell as? BankCell else { return cell }
            atmBankCell.set(bankType: bankAtmType[indexPath.item])
            return atmBankCell
        }
        
    }

}

// MARK: -
// MARK: - UICollectionViewDelegate

extension BankLocationMapController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityCollectionView {
            city = cityName[indexPath.item]
            mapView.clear()
            
            drawMarkersForBankCity(city: cityName[indexPath.item])
            drawMarkersForFilialCity(city: cityName[indexPath.item])
            cityCollectionView.reloadData()
            
        } else if collectionView == atmBankCollectionView {
            self.atmBankCollectionView.reloadData()
             
            let selectedItem = bankAtmType[indexPath.row]
            
            switch selectedItem {
                case .bank:
                    mapView.clear()
                    drawMarkersForFilialCity(city: city)
                case .atm:
                    mapView.clear()
                    drawMarkersForBankCity(city: city)
                case .all:
                    mapView.clear()
                    drawMarkersForFilialCity(city: city)
                    drawMarkersForBankCity(city: city)
            }
        }
    }
}

// MARK: -
// MARK: - UICollectionViewDelegateFlowLayout

extension BankLocationMapController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 6.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        
        let width = (screen.bounds.width - (inset * (6))) / 3
        return CGSize(width: width, height: 40)
    }
}


//extension BankLocationMapController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
//        guard let latitude = location?.coordinate.latitude,
//              let longitude = location?.coordinate.longitude
//        else { return }
//
//
//        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
//        self.mapView?.animate(to: camera)
//        self.locationManager.stopUpdatingLocation()
//    }
//}

