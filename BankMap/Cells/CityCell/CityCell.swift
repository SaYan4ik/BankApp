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
        // Initialization code
    }
    
    func set(name: String) {
        cityLabel.text = name
    }

}
