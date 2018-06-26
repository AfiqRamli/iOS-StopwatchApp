//
//  ViewController.swift
//  Stopwatch-App
//
//  Created by Afiq Ramli on 25/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let timerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lapTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.green, for: .normal)
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lapTimerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Lap", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lapsTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .yellow
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Stopwatch"
        navigationController?.navigationBar.backgroundColor = .white
        
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(timerContainer)
        self.view.addSubview(lapTimerButton)
        self.view.addSubview(playPauseButton)
        self.view.addSubview(lapsTableView)
        
        timerContainer.addSubview(timerLabel)
        timerContainer.addSubview(lapTimerLabel)
        
        NSLayoutConstraint.activate([
            timerContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            timerContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            timerContainer.heightAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: timerContainer.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerContainer.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            lapTimerLabel.trailingAnchor.constraint(equalTo: timerLabel.trailingAnchor),
            lapTimerLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -1)
            ])

        NSLayoutConstraint.activate([
            lapTimerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90),
            lapTimerButton.heightAnchor.constraint(equalToConstant: 60),
            lapTimerButton.widthAnchor.constraint(equalToConstant: 60),
            lapTimerButton.topAnchor.constraint(equalTo: timerContainer.bottomAnchor, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            playPauseButton.topAnchor.constraint(equalTo: lapTimerButton.topAnchor),
            playPauseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -90),
            playPauseButton.widthAnchor.constraint(equalToConstant: 60),
            playPauseButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            lapsTableView.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 20),
            lapsTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            lapsTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            lapsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        
    }
    
    @objc private func buttonAction() {
        
    }
    
}

