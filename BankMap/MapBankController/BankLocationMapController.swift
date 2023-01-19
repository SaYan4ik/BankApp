//
//  BankLocationMapController.swift
//  BankMap
//
//  Created by Александр Янчик on 12.01.23.
//

import UIKit
import GoogleMaps

class BankLocationMapController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var atmBankCollectionView: UICollectionView!
    
    private var data = [BankModel]() {
        didSet {
//            drawMarkerForATM()
        }
    }
    
    private var filials = [FilialModel]() {
        didSet {
//            drawMarkForFilial()
        }
    }
    
    private var cityName = [String]()
    private var bankAtmType = BankType.allCases
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private var city: String = ""


    
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

    }
    
    private func registrationCell() {
        let nib = UINib(nibName: BankCell.id, bundle: nil)
        atmBankCollectionView.register(nib, forCellWithReuseIdentifier: BankCell.id)
        
        let nibCity = UINib(nibName: CityCell.id, bundle: nil)
        cityCollectionView.register(nibCity, forCellWithReuseIdentifier: CityCell.id)
    }
    
    private func getBankInfo() {
        var city = [String]()
        
        GetBankInfo().getInfo(city: "") { banks in
            self.data = banks
            
            banks.forEach { bank in
                if bank.addressType == "г." {
                    city.append(bank.city)
                }
            }
            
            self.cityName = Array(Set(city))
            self.cityCollectionView.reloadData()

        }
    }
    
    private func getFilialInfo() {
        GetBankInfo().getFilialInfo(city: "") { allFilials in
            self.filials = allFilials
        }
    }
    
    private func drawMarkerForATM() {
        data.forEach { bank in
            let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(bank.gpsX) ?? 0.0, longitude: Double(bank.gpsY) ?? 0.0))
            mark.map = mapView
            mark.title = bank.addressType + bank.address + bank.numHouse
            mark.snippet = " Время работы \(bank.warkTime)"
            mark.icon = GMSMarker.markerImage(with: .orange)
            mapView.selectedMarker = mark
            mapView.selectedMarker = nil
        }
    }
    
    private func drawMarkForFilial() {
        filials.forEach { filial in
            guard let gpsX = filial.gpsX,
                  let gpsY = filial.gpsY else { return }
            let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(gpsX) ?? 0.0, longitude: Double(gpsY) ?? 0.0))
            mark.map = mapView
            mark.title = "Филиал \(String(describing: filial.filialName))"
            mark.icon = GMSMarker.markerImage(with: .red)
            mapView.selectedMarker = mark
            mapView.selectedMarker = nil
        }
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
    
    private func drawMarkForBank(bank: BankModel) {
        let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(bank.gpsX) ?? 0.0, longitude: Double(bank.gpsY) ?? 0.0))
        mark.map = mapView
        mark.title = bank.addressType + bank.address + bank.numHouse
        mark.snippet = " Время работы \(bank.warkTime)"
        mark.icon = GMSMarker.markerImage(with: .orange)
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
        mark.icon = GMSMarker.markerImage(with: .red)
        let camera = GMSCameraPosition(latitude: Double(gpsX) ?? 0.0, longitude: Double(gpsY) ?? 0.0, zoom: 8)
        mapView.animate(to: camera)
        mapView.selectedMarker = mark
        mapView.selectedMarker = nil
    }
}


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

extension BankLocationMapController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityCollectionView {
            city = cityName[indexPath.item]
            mapView.clear()
            
            drawMarkersForBankCity(city: cityName[indexPath.item])
            drawMarkersForFilialCity(city: cityName[indexPath.item])
            cityCollectionView.reloadData()
            
        } else if collectionView == atmBankCollectionView {
            self.selectedIndexPath = indexPath
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

extension BankLocationMapController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 16.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        let cellCount = 2.0
        let width = (screen.bounds.width - (inset * (cellCount + 1))) / cellCount
        return CGSize(width: width, height: width)
    }
}
