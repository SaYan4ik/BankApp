//
//  BankCell.swift
//  BankMap
//
//  Created by Александр Янчик on 17.01.23.
//

import UIKit

class BankCell: UICollectionViewCell {
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var bankCellLabel: UILabel!
    static var id = String(describing: BankCell.self)
    var bankType: BankType = .bank
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(bankType: BankType) {
        self.bankType = bankType
        container.layer.borderWidth = self.isSelected ? 2 : 0
        container.layer.borderColor = bankType.borderColor.cgColor
        container.backgroundColor = bankType.tintColor
        bankCellLabel.text = bankType.rawValue
    }

}
