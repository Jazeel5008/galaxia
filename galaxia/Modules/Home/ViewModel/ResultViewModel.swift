//
//  HomeViewModel.swift
//  galaxia
//
//  Created by Meridian Mac Mini on 11/01/23.
//

class ResultViewModel {
    
    // MARK: properties
    
    private var homeData: HomeModel? {
        didSet{
            guard let d = homeData else {return}
            self.setUpView(with: d)
            self.didFetchFinishData?()
        }
    }


    var home: HomeModel!
    var categories = ["Largest" ,"Brightest", "Smallest", "Closest","Largest" ,"Brightest", "Smallest", "Closest"]
    
    
    var error: String? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var dataService: ResultService?
    
    init(dataService: ResultService) {
        self.dataService = dataService
    }
    
    // MARK:- Closures
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFetchFinishData: (() -> ())?
    
    // MARK:- Network Call
    
    func fetchGalaxy() {
        
        self.isLoading = true
        
        self.dataService?.fetchHome(completion: { home, error in
            if let err = error {
                self.isLoading = false
                self.error = err
                return
            }
            
            self.isLoading = false
            self.homeData = home
        })
        
    }
    
    // MARK: UI Logic
    private func setUpView(with data: HomeModel) {
        self.home = data
    }
}
