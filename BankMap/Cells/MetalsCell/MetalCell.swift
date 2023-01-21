//
//  MetalCell.swift
//  BankMap
//
//  Created by Александр Янчик on 19.01.23.
//

import UIKit

class MetalCell: UITableViewCell {

    @IBOutlet weak var weightTenLabel: UILabel!
    @IBOutlet weak var weightTwentyLabel: UILabel!
    @IBOutlet weak var weightFiftyLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var container: UIStackView!
    
    static var id = String(describing:  MetalCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func set(metal: MetalModel, metalType: MetalType) {
        switch metalType {
            case .gold:
                guard let goldTenDouble = Double(metal.goldTen),
                      let goldTwentyDouble = Double(metal.goldTwenty),
                      let goldFiftyDouble = Double(metal.goldFifty)
                else { return }
                
                self.weightTenLabel.isHidden = goldTenDouble <= 0.00
                self.weightTwentyLabel.isHidden = goldTwentyDouble <= 0.00
                self.weightFiftyLabel.isHidden = goldFiftyDouble <= 0.00
                
                self.weightTenLabel.text = "Gold 10:" + " " + metal.goldTen
                self.weightTwentyLabel.text = "Gold 20:" + " " + metal.goldTwenty
                self.weightFiftyLabel.text = "Gold 50:" + " " + metal.goldFifty
                self.bankNameLabel.text = metal.filialName
                
            case .silver:
                guard let silverTenDouble = Double(metal.silverTen),
                      let silverTwentyDouble = Double(metal.silverTwenty),
                      let silverFiftyDouble = Double(metal.silverFifty)
                else { return }
                
                self.weightTenLabel.isHidden = silverTenDouble <= 0.00
                self.weightTwentyLabel.isHidden = silverTwentyDouble <= 0.00
                self.weightFiftyLabel.isHidden = silverFiftyDouble <= 0.00
                
                self.weightTenLabel.text =  "Silver 10:" + " " + metal.silverTen
                self.weightTwentyLabel.text =  "Silver 20:" + " " + metal.silverTwenty
                self.weightFiftyLabel.text =  "Silver 50:" + " " + metal.silverFifty
                self.bankNameLabel.text = metal.filialName
                
            case .platinum:
                guard let platinumTenDouble = Double(metal.platinumTen),
                      let platinumTwentyDouble = Double(metal.platinumTwenty),
                      let platinumFiftyDouble = Double(metal.platinumFifty)
                else { return }
                
                self.weightTenLabel.isHidden = platinumTenDouble <= 0.00
                self.weightTwentyLabel.isHidden = platinumTwentyDouble <= 0.00
                self.weightFiftyLabel.isHidden = platinumFiftyDouble <= 0.00
                
                self.weightTenLabel.text =  "Platinum 10:" + " " + metal.platinumTen
                self.weightTwentyLabel.text = "Platinum 20:" + " " + metal.platinumTwenty
                self.weightFiftyLabel.text = "Platinum 50:" + " " + metal.platinumFifty
                self.bankNameLabel.text = metal.filialName
        }
    }
    
    private func setStyle() {
        container.layer.cornerRadius = 12
    }
    
}
