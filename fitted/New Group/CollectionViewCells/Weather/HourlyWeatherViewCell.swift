//
//  HourlyWeatherViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 18.02.21.
//

import UIKit

class HourlyWeatherViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var Weather: currentWeather?
    
    var hourlyWeather: [String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourViewCell.nib(), forCellWithReuseIdentifier: HourViewCell.identifier)
        
        
        for i in 1...9 {
            hourlyWeather.append("1\(i):00")
        }
        
    }
    
    static let identifier = "HourlyWeatherViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyWeatherViewCell", bundle: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourViewCell.identifier, for: indexPath) as! HourViewCell
        
        if let weather = Weather {
            cell.configure(weather: weather, timeHour: hourlyWeather[indexPath.item])
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: collectionView.frame.height)
    }

}
