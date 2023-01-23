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
        
    }
    
    func set(bankType: BankType) {
        self.bankType = bankType
        bankCellLabel.text = bankType.rawValue
        applyShadow(cornerRadius: 12)
    }

    
    private func applyShadow(cornerRadius: CGFloat) {
        self.container.layer.cornerRadius = cornerRadius
        self.container.layer.masksToBounds = true
        self.container.layer.shadowRadius = 4.0
        self.container.layer.shadowOpacity = 0.30
        self.container.layer.shadowColor = UIColor.gray.cgColor
        self.container.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
