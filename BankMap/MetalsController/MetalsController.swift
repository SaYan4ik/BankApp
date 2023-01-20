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
    private var metalType = MetalType.allCases
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getMetalInfo()
        registerCell()
    }
    
    @IBAction func segmentDidChange(_ sender: Any) {
        guard segment.selectedSegmentIndex < 3 else { return }
        self.selectedIndex = segment.selectedSegmentIndex
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
            self.tableView.reloadData()
        }
    }
    
    
}

extension MetalsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metalsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MetalCell.id, for: indexPath)
        
        guard let metalCell = cell as? MetalCell else { return cell }

        switch selectedIndex {
            case 0:
                metalCell.set(metal: metalsData[indexPath.row], metalType: .gold)
                return metalCell
            case 1:
                metalCell.set(metal: metalsData[indexPath.row], metalType: .silver)
                return metalCell
            case 2:
                metalCell.set(metal: metalsData[indexPath.row], metalType: .platinum)
                return metalCell
            default:
                return metalCell
        }
//        return metalCell
    }
    
    
}
