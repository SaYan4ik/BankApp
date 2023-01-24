//
//  HistoryCell.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var requestHistoreyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static var id = String(describing: HistoryCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(request: HistoryRealmModel) {
        self.requestHistoreyLabel.text = request.request
        self.dateLabel.text = request.date
        self.layer.cornerRadius = 12
    }
    
}
