//
//  DetailViewController.swift
//  Weather
//
//  Created by Tim Li on 3/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var cityTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempMaxMin: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var visibility: UILabel!
    
    var city: City!
    lazy var viewModel : DetailViewModel = {
        return DetailViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTopConstraint.constant = -80
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCityTopConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.passData(city)
        viewModel.updateViewClosure = { [weak self] () in
            self?.name.text = self!.viewModel.city?.name
            self?.summary.text = self!.viewModel.city?.summary
            self?.temp.text = self!.viewModel.city?.temp
            self?.tempMaxMin.text = (self!.viewModel.city?.minTemp)! + "/" + (self!.viewModel.city?.maxTemp)!
            self?.humidity.text = self!.viewModel.city?.humidity
            self?.pressure.text = self!.viewModel.city?.pressure
            self?.visibility.text = self!.viewModel.city?.visibility
        }
        
    }
    
    func setCityTopConstraint() {
        cityTopConstraint.constant = 10
        
        UIView.animate(withDuration: 1, delay: 0, options: [.transitionFlipFromRight], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }

}
