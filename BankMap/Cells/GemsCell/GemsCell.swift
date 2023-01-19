//
//  GemsCell.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import UIKit

class GemsCell: UITableViewCell {
    @IBOutlet weak var attestatLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var edgeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    
    @IBOutlet weak var container: UIStackView!
    
    static var id = String(describing: GemsCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(gem: GemModel) {
        self.attestatLabel.text = gem.attestat
        self.nameLabel.text = gem.name
        self.edgeLabel.text = gem.grani
        self.weightLabel.text = gem.weight
        self.colorLabel.text = gem.color
        self.costLabel.text = gem.cost
        self.bankNameLabel.text = "\(gem.cityType)\(gem.city) \(gem.filialName)"
        setupData()
    }
    
    private func setupData() {
        container.layer.cornerRadius = 12
    }
    
}
