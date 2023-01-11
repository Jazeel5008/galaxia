//
//  ResultTableViewCell.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit
import Kingfisher

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var img_image: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func renderCell(data:Galaxy){
        
        DispatchQueue.main.async {
            
            self.lbl_title.text = data.title ?? ""
            self.lbl_desc.text = data.description ?? "Not available"
            if let img = data.imageUrl {
                self.img_image.kf.setImage(with: URL(string: img))
            }
            
            
        }
    }
   
    
}
