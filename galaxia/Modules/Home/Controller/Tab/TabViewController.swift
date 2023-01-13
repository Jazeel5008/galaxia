//
//  TabViewController.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 13/01/23.
//

import UIKit

class TabViewController: UIViewController, PagerScrollViewDelegate {

    @IBOutlet weak var pagerView: PagerScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupPagerView()
        
    }
    

    func setupPagerView(){
        
        let home = self.storyboard?.instantiateViewController(withIdentifier: "\(HomeViewController.self)") as! HomeViewController
        
        self.pagerView.pagerDelegate = self
        self.pagerView.setPagerScrollView(toParentVC: self, pagesVC: [home])
        self.pagerView.setPage(withIndex: 0, animated: true)
        
    }
    

}
