//
//  WeatherViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 18.02.21.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var Weather: currentWeather?
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let weather = self.Weather {
            
            weather.printWeather()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemTeal
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(WeatherOverviewViewCell.nib(), forCellWithReuseIdentifier: WeatherOverviewViewCell.identifier)
        collectionView.register(HourlyWeatherViewCell.nib(), forCellWithReuseIdentifier: HourlyWeatherViewCell.identifier)
        collectionView.register(WeatherForecastViewCell.nib(), forCellWithReuseIdentifier: WeatherForecastViewCell.identifier)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 5
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherOverviewViewCell.identifier, for: indexPath) as! WeatherOverviewViewCell
            
            cell.configure(weather: Weather!)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherViewCell.identifier, for: indexPath) as! HourlyWeatherViewCell
            cell.Weather = self.Weather!
            cell.collectionView.backgroundColor = .systemTeal
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastViewCell.identifier, for: indexPath) as! WeatherForecastViewCell
            cell.configure(weather: Weather!)
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 112)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 56)
        default:
            return .zero
        }
        
        
    }
}
