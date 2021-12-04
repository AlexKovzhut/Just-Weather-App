//
//  FavoriteCitysViewController.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 02.12.2021.
//

import UIKit
import CoreLocation

class FavCitysViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavBar()
        setStyle()
        setLayout()
    }
    
    @objc func addCityButtonPressed() {
        
    }
}


extension FavCitysViewController {
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    private func setupNavBar() {
        navigationItem.searchController = searchController
        
        searchController.searchBar.placeholder = "Search here"
        searchController.obscuresBackgroundDuringPresentation = false
        
        let addButton = createCustomButton(image: "plus.circle", selector: #selector(addCityButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setStyle() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavCityTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension FavCitysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavCityTableViewCell
        
        return cell
    }
}

extension FavCitysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherVC = WeatherViewController()
        
        navigationController?.pushViewController(weatherVC, animated: true)
    }
}

extension FavCitysViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

