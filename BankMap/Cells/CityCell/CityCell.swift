//
//  CityCell.swift
//  BankMap
//
//  Created by Александр Янчик on 17.01.23.
//

import UIKit

class CityCell: UICollectionViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    
    static var id = String(describing: CityCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(name: String) {
        cityLabel.text = name
        container.layer.borderWidth = self.isSelected ? 2 : 0
        self.container.layer.cornerRadius = 12
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
