//
//  GalaxyCollectionViewCell.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit

class GalaxyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func renderCell(name:String) {
        
        DispatchQueue.main.async {
            self.lbl_title.text = name
        }
        
    }

}
