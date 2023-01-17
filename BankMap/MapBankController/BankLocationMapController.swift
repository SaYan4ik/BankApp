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
    
    var marks = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBankInfo()
    }
    
    private func getBankInfo() {
        GetBankInfo().getInfo(city: "") { banks in
            self.data = banks
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
            marks.append(mark)
        }
    }
    
    private func drawMarkForFilial() {
        filials.forEach { filial in
            let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(filial.gpsX) ?? 0.0, longitude: Double(filial.gpsY) ?? 0.0))
            mark.map = mapView
            mark.title = "Филиал \(filial.filialName)"
            mapView.selectedMarker = mark
            mapView.selectedMarker = nil
            marks.append(mark)
        }
    }

}
