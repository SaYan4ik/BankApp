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
    @IBOutlet weak var statusCodeLabel: UILabel!
    
    @IBOutlet weak var container: UIStackView!
    
    static var id = String(describing: HistoryCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(request: HistoryRealmModel) {
        self.requestHistoreyLabel.text = request.request
        self.statusCodeLabel.text = "Status code: " + String(request.statusCode)
        self.dateLabel.text = "Date of request \(request.date.formatted())"
        self.container.layer.cornerRadius = 12
    }
    
}
