//
//  HomeViewController.swift
//  Weather
//
//  Created by Tim Li on 3/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UITableViewController {

    let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorView.Style.whiteLarge)
    lazy var viewModel : HomeViewModel = {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        initTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
        setNavigationBar()
        
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func initUI() {
        
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func initViewModel() {
        viewModel.fetchData()
        viewModel.setTimer()
        
        viewModel.updateTableViewClosure = { [weak self] () in
            self?.tableView.reloadData()
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                }else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func initTableView() {
        self.tableView.backgroundView = GradientView(frame: UIScreen.main.bounds)
        self.tableView.estimatedRowHeight = 100
        self.tableView.registerCell(nibName: CityCell.nameOfClass)
        
        let addCityView = UIView.init(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 100))
        addCityView.layer.borderWidth = 0.5
        addCityView.layer.cornerRadius = 5
        addCityView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tableView.tableFooterView = addCityView
        
        let addBtn = UIButton()
        addBtn.addTarget(self, action: #selector(self.addCity), for: .touchUpInside)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addCityView.addSubview(addBtn)
        addBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(addCityView.snp.right).inset(30)
            $0.height.equalTo(25)
            $0.width.equalTo(25)
        }
    }
    
    @objc func addCity() {
        performSegue(withIdentifier: Constants.addCitySegueIdentifier, sender: nil)
    }
    
    func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3607843137, green: 0.8078431373, blue: 0.8117647059, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailSegueIdentifier, let indexPath = sender as? IndexPath {
            let vc = segue.destination as? DetailViewController
            let city = self.viewModel.cities[indexPath.row]
            vc!.city = city
        }
    }
}

// MARK: Table View
extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.nameOfClass, for: indexPath) as! CityCell
        let city = self.viewModel.cities[indexPath.row]
        cell.nameLbl.text = city.name
        cell.tempLbl.text = city.temp
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteCell(index: indexPath.row)
            tableView.deleteRows(at:[indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.detailSegueIdentifier, sender: indexPath)
    }
    
}
