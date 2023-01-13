//
//  ResultViewController.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var cv_categories: UICollectionView!
    @IBOutlet weak var tv_galaxy: UITableView!
    
    // MARK: - View Model
    let viewModel = ResultViewModel(dataService: ResultService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchGalaxy()
    }
    
    
    
    func fetchGalaxy(){
        
        viewModel.showAlertClosure = {
            
            if let err = self.viewModel.error {
                print(err)
            }
        }
        
        viewModel.updateLoadingStatus = {
            
            DispatchQueue.main.async {
                self.viewModel.isLoading ? self.activityStartAnimating() : self.activityStopAnimating()
            }
            
        }
        
        viewModel.fetchGalaxy()
        
        viewModel.didFetchFinishData = {
            
            self.registerCells()
            
        }
        
    }
    
    func registerCells(){
        //Register Galaxy Table
        DispatchQueue.main.async {
            self.tv_galaxy.register(UINib(nibName: "\(ResultCell.self)", bundle: nil), forCellReuseIdentifier: "\(ResultCell.self)")
            self.tv_galaxy.delegate = self
            self.tv_galaxy.dataSource = self
            self.tv_galaxy.reloadData()
            
            self.tv_galaxy.layoutIfNeeded()
        }
        
        
        //Register Categories Collection
        DispatchQueue.main.async {
            self.cv_categories.register(UINib(nibName: "\(CatCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CatCollectionViewCell.self)")
            self.cv_categories.delegate = self
            self.cv_categories.dataSource = self
            self.cv_categories.reloadData()
            self.cv_categories.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        }
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension ResultViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            case cv_categories :
                return self.viewModel.categories.count
            
            default:
                return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
            case cv_categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CatCollectionViewCell.self)", for: indexPath) as! CatCollectionViewCell
                
                cell.render(title: self.viewModel.categories[indexPath.row])
                
                return cell
            default:
                return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        
        switch collectionView {
            
            case cv_categories :
                
                return CGSize(width:size.width / 4, height:50)
            default:
                print("Default size")
                return CGSize(width: 0, height: 0)
        }
        
    }
   
    
}

extension ResultViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.home.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let galaxies = self.viewModel.home.result{
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ResultCell.self)", for: indexPath) as! ResultCell
            cell.renderCell(data: galaxies[indexPath.row])
            
            DispatchQueue.main.async {
                cell.layoutIfNeeded()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return UITableView.automaticDimension
        
        
    }
    
    
    
    
}
