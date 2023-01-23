//
//  MetalsController.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import UIKit

class MetalsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    private var metalsData = [MetalModel]()
    private var filterMetals = [MetalModel]()
    
    private var metalType: MetalType = .gold
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMetalInfo()
        registerCell()
        tableView.dataSource = self
    }
    
    @IBAction func segmentDidChange(_ sender: Any) {
        guard segment.selectedSegmentIndex < 3 else { return }
        self.selectedIndex = segment.selectedSegmentIndex
        
        switch selectedIndex {
            case 0:
                filterByGold()
                metalType = .gold
            case 1:
                filterBySilver()
                metalType = .silver
            case 2:
                filterByPlatinum()
                metalType = .platinum
            default:
                break
        }
        
        self.tableView.reloadData()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: MetalCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MetalCell.id)
    }
    
    private func getMetalInfo() {
        GetBankInfo().getMetalsInfo(city: "") { [weak self] metals in
            guard let self else { return }
            self.metalsData = metals
            self.filterByGold()
            self.tableView.reloadData()
        }
    }
    
    private func filterByGold() {
        filterMetals.removeAll()
        metalsData.forEach { metal in
            guard let goldTenDouble = Double(metal.goldTen),
                  let goldTwentyDouble = Double(metal.goldTwenty),
                  let goldFiftyDouble = Double(metal.goldFifty)
            else { return }
            
            if goldTenDouble <= 0.00, goldTwentyDouble <= 0.00, goldFiftyDouble <= 0.00 {
                print("nothing to add")
            } else {
                filterMetals.append(metal)
            }
            
        }
    }
    
    private func filterBySilver() {
        filterMetals.removeAll()
        metalsData.forEach { metal in
            guard let silverTenDouble = Double(metal.silverTen),
                  let silverTwentyDouble = Double(metal.silverTwenty),
                  let silverFiftyDouble = Double(metal.silverFifty)
            else { return }
            
            if silverTenDouble <= 0.00,silverTwentyDouble <= 0.00, silverFiftyDouble <= 0.00 {
                print("nothing to add")
            } else {
                filterMetals.append(metal)
            }
            
        }
    }
    
    private func filterByPlatinum() {
        filterMetals.removeAll()
        metalsData.forEach { metal in
            guard let platinumTenDouble = Double(metal.platinumTen),
                  let platinumTwentyDouble = Double(metal.platinumTwenty),
                  let platinumFiftyDouble = Double(metal.platinumFifty)
            else { return }
            
            if platinumTenDouble <= 0.00, platinumTwentyDouble <= 0.00, platinumFiftyDouble <= 0.00 {
                print("nothing to add")
            } else {
                filterMetals.append(metal)
            }
        }
    }
    
}
    
extension MetalsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMetals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MetalCell.id, for: indexPath)
        guard let metalCell = cell as? MetalCell else { return cell }
        metalCell.set(metal: filterMetals[indexPath.row], metalType: metalType)
        return metalCell
    }
}
