//
//  ViewController.swift
//  Stopwatch-App
//
//  Created by Afiq Ramli on 25/06/2018.
//  Copyright © 2018 Afiq Ramli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Enums
    private enum buttonState: String {
        case play = "Play"
        case stop = "Stop"
        case reset = "Reset"
        case lap = "Lap"
    }
    
    //MARK: - Variables
    let mainStopwatch: Stopwatch = Stopwatch()
    let lapStopwatch: Stopwatch = Stopwatch()
    var isPlay: Bool = false
    let cellId = "cellID"
    var laps: [String] = []
    
    
    //MARK: - UI components
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
        button.addTarget(self, action: #selector(playPausedPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lapTimerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Lap", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(lapPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var lapsTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(LapCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lapTimerButton.isEnabled = false
        
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
    
    @objc private func playPausedPressed() {
        print("Play button pressed")
        lapTimerButton.isEnabled = true
        if !isPlay {
            
            startTimer()
            changeButtonLabel(playPauseButton, title: .stop, titleColor: .red)
            changeButtonLabel(lapTimerButton, title: .lap, titleColor: .black)
            isPlay = true
            
        } else {
            
            stopTimer()
            changeButtonLabel(playPauseButton, title: .play, titleColor: .green)
            changeButtonLabel(lapTimerButton, title: .reset, titleColor: .black)
            isPlay = false
            
        }
    }
    
    @objc private func lapPressed() {
        print("Lap / Reset button pressed")
        
        if !isPlay {
            
            resetMainTimer()
            resetLapTimer()
            changeButtonLabel(lapTimerButton, title: .lap, titleColor: .black)
            laps.removeAll()
            lapsTableView.reloadSections([0], with: .left)
            lapTimerButton.isEnabled = false
            
        } else {
            // Add Laps to tableView
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
            lapsTableView.reloadData()
            resetLapTimer()
            
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
        }
    }

    
    //MARK: - Helper methods
    private func changeButtonLabel(_ button: UIButton, title: buttonState, titleColor: UIColor) {
        button.setTitle(title.rawValue, for: UIControlState())
        button.setTitleColor(titleColor, for: UIControlState())
    }
    
    private func startTimer() {
        
        unowned let weakSelf = self
        
        mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
        lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
        
        RunLoop.current.add(mainStopwatch.timer, forMode: .commonModes)
        RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
    }
    
    private func stopTimer() {
        print("Timer Stop")
        
        mainStopwatch.timer.invalidate()
        lapStopwatch.timer.invalidate()
    }
    
    @objc private func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    @objc private func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", stopwatch.counter.truncatingRemainder(dividingBy: 60))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
        
    }
    
    private func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
    }
    
    private func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    private func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
}

//MARK: - UITableViewDelegate method
extension ViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource method
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LapCell
        
        cell.lapNumberLabel.text = "Lap \(laps.count - indexPath.row)"
        cell.lapTimeLabel.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
    
        return cell
    }

}







