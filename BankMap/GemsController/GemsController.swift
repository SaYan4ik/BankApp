//
//  GemsController.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import UIKit

class GemsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    private var gemsData = [GemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGemData()
        registerCell()
        tableView.dataSource = self

    }
    
    private func getGemData() {
        spiner.startAnimating()
        GetBankInfo().getGemsInfo(city: "") { [weak self] gems in
            guard let self else { return }
            self.gemsData = gems
            self.tableView.reloadData()
            self.spiner.stopAnimating()
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: GemsCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GemsCell.id)
    }

}

extension GemsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gemsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GemsCell.id, for: indexPath)
        guard let gemCell = cell as? GemsCell else { return cell }
        gemCell.set(gem: gemsData[indexPath.row])
        return gemCell
    }
}
