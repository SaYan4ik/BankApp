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
            drawMarker()
        }
    }
    
    var marks = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBankInfo()
    }
    
    func getBankInfo() {
        GetBankInfo().getInfo(city: "Минск") { banks in
            self.data = banks
        }
    }
    
    private func drawMarker() {
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
    
    private func drawMarkForBank(bank: BankModel) {
        let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(bank.gpsX) ?? 0.0, longitude: Double(bank.gpsY) ?? 0.0))
        mark.map = mapView
        mark.title = bank.addressType + bank.address + bank.numHouse
        mark.snippet = " Время работы \(bank.warkTime)"
        mark.icon = GMSMarker.markerImage(with: .orange)
        mapView.selectedMarker = mark
        mapView.selectedMarker = nil
        marks.append(mark)
    }
    
    @IBAction func bynButtonDidTap(_ sender: Any) {
        mapView.clear()
        data.forEach { bank in
            let currency = bank.currency.split{ $0 == " " }
            if currency.contains("BYN") {
                drawMarkForBank(bank: bank)
            }
        }
    }
    
    @IBAction func allBanksDidTap(_ sender: Any) {
        mapView.clear()
        drawMarker()
    }
    
    @IBAction func usdButtonDidTap(_ sender: Any) {
        mapView.clear()
        data.forEach { bank in
            let currency = bank.currency.split{ $0 == " " }
            if currency.contains("USD") {
                drawMarkForBank(bank: bank)
            }
        }
    }
    
    @IBAction func eurButtonDidTap(_ sender: Any) {
        mapView.clear()
        data.forEach { bank in
            let currency = bank.currency.split{ $0 == " " }
            if currency.contains("EUR") {
                drawMarkForBank(bank: bank)
            }
        }
    }
    
}
