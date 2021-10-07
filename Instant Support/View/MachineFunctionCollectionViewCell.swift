//
//  CollectionViewCell.swift
//  Instant Support
//
//  Created by Danny Lin on 1/29/21.
//

import UIKit

class MachineFunctionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var functionImageView: UIImageView!
    @IBOutlet weak var functionLabel: UILabel!
    
    //let defaultBackgroundColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = nil
        contentView.layer.borderColor = UIColor.init(named: "SystemWhiteforOldiOS")?.cgColor
        contentView.layer.borderWidth = 2
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? UIColor(white: 23/255.0, alpha: 1.0) : nil
        }
    }
    
    override var isSelected: Bool{
        didSet{
            self.contentView.backgroundColor = isSelected ? UIColor(white: 233/255, alpha: 1) : nil
        }
    }
    
    
}
