//
//  ResultViewController.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var cv_categories: UICollectionView!
    @IBOutlet weak var cv_galaxy: UICollectionView!
    
    // MARK: - View Model
    let viewModel = ResultViewModel(dataService: ResultService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
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
            self.cv_galaxy.register(UINib(nibName: "\(ResultCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(ResultCollectionViewCell.self)")
            self.cv_galaxy.delegate = self
            self.cv_galaxy.dataSource = self
            self.cv_galaxy.reloadData()
            self.cv_galaxy.layoutIfNeeded()
        }
        
        
        //Register Categories Collection
        DispatchQueue.main.async {
            self.cv_categories.register(UINib(nibName: "\(CategoryCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryCollectionViewCell.self)")
            self.cv_categories.delegate = self
            self.cv_categories.dataSource = self
            self.cv_categories.reloadData()
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
            case cv_galaxy :
                return self.viewModel.home.result?.count ?? 0
            default:
                return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            case cv_galaxy:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ResultCollectionViewCell.self)", for: indexPath) as! ResultCollectionViewCell
                
                if let galaxies = self.viewModel.home.result {
                    cell.renderCell(data: galaxies[indexPath.row])
                }
                
                return cell
                
                
                
            case cv_categories:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCollectionViewCell.self)", for: indexPath) as! CategoryCollectionViewCell
                
                cell.renderCell(title: self.viewModel.categories[indexPath.row])
                
                return cell
            default:
                return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        
        switch collectionView {
            case cv_galaxy :
                return CGSize(width: size.width, height: 200)
            case cv_categories :
               
                return CGSize(width:size.width / 4, height:200)
            default:
                print("Default size")
                return CGSize(width: 0, height: 0)
        }
        
    }
    
    
}
