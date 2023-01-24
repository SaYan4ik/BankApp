//
//  HistoryController.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import UIKit

class HistoryController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var historyData = RealmManager<HistoryRealmModel>().read() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: HistoryCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HistoryCell.id)
    }

}

extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.id, for: indexPath)
        guard let historyCell = cell as? HistoryCell else { return cell }
        historyCell.set(request: historyData[indexPath.row])
        
        return historyCell
    }
    
    
}
