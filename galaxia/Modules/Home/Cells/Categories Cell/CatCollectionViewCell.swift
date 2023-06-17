//
//  CatCollectionViewCell.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 13/01/23.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            lbl_title.textColor = isSelected ? .APP_TEXTDARK : .APP_TEXTLIGHT
        }
    }

    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func render(title:String){
        DispatchQueue.main.async {
            self.lbl_title.text = title
        }
    }

}


