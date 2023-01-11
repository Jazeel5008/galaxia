//
//  HomeViewController.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit


class HomeViewController: UIViewController {

   
    let viewModel = HomeViewModel(dataService: HomeService())
    @IBOutlet weak var cv_galaxies: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register Galaxy Cell
        self.cv_galaxies.register(UINib(nibName: "\(GalaxyCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier:"\(GalaxyCollectionViewCell.self)")
        
        
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
            self.viewModel.isLoading ? print("loading") : print("done")
        }
        
        viewModel.fetchGalaxy()
        
        viewModel.didFetchFinishData = {
            DispatchQueue.main.async {
                self.cv_galaxies.delegate = self
                self.cv_galaxies.dataSource = self
                self.cv_galaxies.reloadData()
            }
            
        }
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "\(ResultViewController.self)")
        
        self.navigationController?.pushViewController(next!, animated: true)
    }
    

}


extension HomeViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.viewModel.home.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GalaxyCollectionViewCell.self)", for: indexPath) as! GalaxyCollectionViewCell
        
        if let data = self.viewModel.home.result {
            cell.renderCell(data: data[indexPath.row])
        }
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.cv_galaxies.frame.size.width / 4, height: self.cv_galaxies.bounds.height)
        
    }

}
