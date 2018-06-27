//
//  LapCell.swift
//  Stopwatch-App
//
//  Created by Afiq Ramli on 26/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class LapCell: UITableViewCell {
    
    let lapNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Lap 1"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lapTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(lapNumberLabel)
        self.addSubview(lapTimeLabel)
        
        NSLayoutConstraint.activate([
            lapNumberLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100),
            lapNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            lapTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100),
            lapTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
    }
}








