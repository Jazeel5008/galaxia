//
//  ResultViewController.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    var data : [Galaxy]?
    var categories = ["Largest" ,"Brightest", "Smallest", "Closest"]
    
    @IBOutlet weak var cv_categories: UICollectionView!
    @IBOutlet weak var tv_galaxy: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerCells()
        
       
    }
    
    func registerCells(){
        //Register Galaxy Table
        self.tv_galaxy.register(UINib(nibName: "\(ResultTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(ResultTableViewCell.self)")
        self.tv_galaxy.delegate = self
        self.tv_galaxy.dataSource = self
        self.tv_galaxy.reloadData()
            
        
        
        
        
        //Register Categories Collection
        self.cv_categories.register(UINib(nibName: "\(CategoryCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryCollectionViewCell.self)")
        self.cv_categories.delegate = self
        self.cv_categories.dataSource = self
        self.cv_categories.reloadData()
    }

}

extension ResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ResultTableViewCell.self)") as! ResultTableViewCell
        
        DispatchQueue.main.async {
            if let data = self.data {
                cell.renderCell(data: data[indexPath.row])
                cell.layoutIfNeeded()
            }
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   
}

extension ResultViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCollectionViewCell.self)", for: indexPath) as! CategoryCollectionViewCell
        
        cell.renderCell(title: self.categories[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame.size
        
        return CGSize(width:size.width / 4 , height: size.height)
        
    }
    
    
}
