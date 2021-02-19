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
        
        collectionView.register(WeatherOverviewViewCell.nib(), forCellWithReuseIdentifier: WeatherOverviewViewCell.identifier)
        
        
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherOverviewViewCell.identifier, for: indexPath) as! WeatherOverviewViewCell
        cell.backgroundColor = .systemTeal
        cell.configure(weather: Weather!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
    }
}
