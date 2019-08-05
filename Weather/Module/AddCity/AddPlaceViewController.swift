//
//  AddCityViewController.swift
//  Weather
//
//  Created by Tim Li on 4/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var viewModel : AddCityViewModel = {
        return AddCityViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
        
    }

    func initViewModel() {
        viewModel.updateTableViewClosure = { [weak self] () in
            self?.tableView.reloadData()
        }
        
        viewModel.selectCityClosure = { [weak self] () in
            _ = self?.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell")
        cell?.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell?.textLabel?.text = viewModel.searchResult[indexPath.row]["name"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCity(index: indexPath.row)
    }
}

extension AddCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            viewModel.searchCity(by: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.cancelBtnClicked()
    }
}
