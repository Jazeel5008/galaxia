//
//  HomeViewController.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

import UIKit
import FSPagerView


class HomeViewController: UIViewController {

   
    // MARK: - ViewModel
    let viewModel = HomeViewModel()
    
    
    @IBOutlet weak var cv_galaxies: UICollectionView!
    @IBOutlet weak var bannerView: FSPagerView! {
        didSet {
            self.bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            
        }
    }
    @IBOutlet weak var banner_page: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.renderBannerView() // Top BannerView
        self.renderGalaxiesCollection() // Galaxies
    }
    
    func renderBannerView(){
        
        DispatchQueue.main.async {
            
            self.bannerView.delegate = self
            self.bannerView.dataSource = self
            self.bannerView.automaticSlidingInterval = 3.0
            self.bannerView.interitemSpacing = 10
            self.bannerView.transformer = FSPagerViewTransformer(type: .linear)
            self.banner_page.numberOfPages = self.viewModel.banners.count
            self.bannerView.reloadData()
        
        }
        
    }
    
    func renderGalaxiesCollection() {
        
        DispatchQueue.main.async {
            self.cv_galaxies.register(UINib(nibName: "\(GalaxyCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier:"\(GalaxyCollectionViewCell.self)")
            self.cv_galaxies.delegate = self
            self.cv_galaxies.dataSource = self
        }
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "\(ResultViewController.self)") as! ResultViewController
        
        self.navigationController?.pushViewController(next, animated: true)
    }
    

}


//Banner
extension HomeViewController : FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.viewModel.banners.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        let image = self.viewModel.banners[index]
        DispatchQueue.main.async {
            cell.imageView!.image = UIImage(named: image)
            cell.imageView?.clipsToBounds = true
            cell.imageView?.cornerRadius = 15
        }
        
        return cell
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        
        DispatchQueue.main.async {
            self.banner_page.currentPage = index
        }
        
    }
    
    
    
}


extension HomeViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.galaxies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GalaxyCollectionViewCell.self)", for: indexPath) as! GalaxyCollectionViewCell
        
        cell.lbl_title.text = self.viewModel.galaxies[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 4 , height: collectionView.bounds.height)
        
    }
    
    
}


