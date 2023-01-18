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
            drawMarkerForATM()
        }
    }
    
    private var filials = [FilialModel]() {
        didSet {
            drawMarkForFilial()
        }
    }
    
    private var cityName = [String]()

    var marks = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilialInfo()
        getBankInfo()
        registrationCell()
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        atmBankCollectionView.dataSource = self
        atmBankCollectionView.delegate = self
    }
    
    private func registrationCell() {
        let nib = UINib(nibName: BankCell.id, bundle: nil)
        cityCollectionView.register(nib, forCellWithReuseIdentifier: BankCell.id)
        
        let nibCity = UINib(nibName: CityCell.id, bundle: nil)
        cityCollectionView.register(nibCity, forCellWithReuseIdentifier: CityCell.id)
    }
    
    private func getBankInfo() {
        var city = [String]()
        
        GetBankInfo().getInfo(city: "") { banks in
            self.data = banks
            
            banks.forEach { bank in
                city.append(bank.city)
            }
            
            self.cityName = Array(Set(city))
            self.cityCollectionView.reloadData()

        }
    }
    
    private func getFilialInfo() {
        GetBankInfo().getFilialInfo { allFilials in
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

}


extension BankLocationMapController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath)
        guard let cityCell = cell as? CityCell else { return cell }
        cityCell.set(name: cityName[indexPath.item])
        return cityCell
    }

}

extension BankLocationMapController: UICollectionViewDelegate {
    
}
