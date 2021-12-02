//
//  FavCityTableViewCell.swift
//  Weather Application
//
//  Created by Alexander Kovzhut on 02.12.2021.
//

import UIKit

class FavCityTableViewCell: UITableViewCell {
    
    private let cityLabel = UILabel()
    private let conditionImageView = UIImageView()
    private let temperaturelabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavCityTableViewCell {
    private func setStyle() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 20)
        cityLabel.text = "Default City"
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.backgroundColor = .green
        
        temperaturelabel.translatesAutoresizingMaskIntoConstraints = false
        temperaturelabel.font = UIFont.systemFont(ofSize: 20)
        temperaturelabel.text = "11ºC"
    }
    
    private func setLayout() {
//        self.backgroundColor = .clear
//        self.selectionStyle = .none
        
        self.addSubview(cityLabel)
        self.addSubview(conditionImageView)
        self.addSubview(temperaturelabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            
            conditionImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            conditionImageView.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 30),
            
            temperaturelabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            temperaturelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15)
        ])
    }
}
