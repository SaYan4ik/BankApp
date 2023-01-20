//
//  MetalCell.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import UIKit

class MetalCell: UITableViewCell {

    @IBOutlet weak var metalTypeLabel: UILabel!
    @IBOutlet weak var weightTenLabel: UILabel!
    @IBOutlet weak var weightTwentyLabel: UILabel!
    @IBOutlet weak var weightFiftyLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    
    @IBOutlet weak var container: UIStackView!
    
    static var id = String(describing:  MetalCell.self)
//    private var metalType: MetalType = .gold
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func set(metal: MetalModel, metalType: MetalType) {
        switch metalType {
            case .gold:
                self.metalTypeLabel.text = "Gold"
                self.weightTenLabel.text = metal.goldTen
                self.weightTwentyLabel.text = metal.goldTwenty
                self.weightFiftyLabel.text = metal.goldFifty
                self.bankNameLabel.text = metal.filialName
            case .silver:
                self.metalTypeLabel.text = "Silver"
                self.weightTenLabel.text = metal.silverTen
                self.weightTwentyLabel.text = metal.silverTwenty
                self.weightFiftyLabel.text = metal.silverFifty
                self.bankNameLabel.text = metal.filialName
            case .platinum:
                self.metalTypeLabel.text = "Platinum"
                self.weightTenLabel.text = metal.platinumTen
                self.weightTwentyLabel.text = metal.platinumTwenty
                self.weightFiftyLabel.text = metal.platinumFifty
                self.bankNameLabel.text = metal.filialName
        }

    }
    
    private func setStyle() {
        container.layer.cornerRadius = 12
    }
    

}
