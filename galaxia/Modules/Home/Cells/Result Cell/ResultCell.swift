//
//  ResultCollectionViewCell.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 13/01/23.
//

import UIKit
import Kingfisher

class ResultCell: UITableViewCell {

    @IBOutlet weak var img_image: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layoutIfNeeded()
    }

    func renderCell(data:Galaxy){
        
        DispatchQueue.main.async {
            
            self.lbl_title.text = data.title ?? ""
            self.lbl_desc.text = data.description ?? "Not available"
            if let img = data.imageUrl {
                let size = self.img_image.frame.size
                let scale = UIScreen.main.scale
                let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: size.width * scale, height: size.height * scale))
                self.img_image.kf.setImage(with: URL(string: img),options: [.processor(resizingProcessor),.cacheOriginalImage,.transition(.fade(1.0))])
            
            }
            
            
        }
    }
   
    
}
