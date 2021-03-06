//
//  DiscoverViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 20.11.20.
//

import UIKit
import CoreLocation

class DiscoverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CLLocationManagerDelegate, DiscoverDelegate {
    
    
    func didSelectDiscover(indexPath: IndexPath) {
        discover.selectedCategory(forIndexPath: indexPath)
        print("selected protocol: \(String(describing: discover.selectedCategory))")
        
        self.performSegue(withIdentifier: "showDiscoverSegue", sender: self)
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let headerHeight: CGFloat = 42
    let discoverSavedRatio: CGFloat = 0.15
    let sections = ["Discover", "Saved"]
    
    var savedOutfits: [Outfit] = []
    
    let titleViewHeight: CGFloat = 55
    let titleViewWidth: CGFloat = 218
    
    /// NavigationBar Views
    let customTitleView = UIView()
    let weatherImage = UIImageView()
    let temperatureLabel = UILabel()
    let rangeLabel = UILabel()
    let descriptionLabel = UILabel()
    let locationLabel = UILabel()
    
    /// Location Manager and Weather variables
    var coordinates: CLLocation?
    var weather: currentWeather?
    var locationManager = CLLocationManager()
    
    
    let coreDataManager = CoreDataManager()
    
    var refresher: UIRefreshControl?

    let discover = Discover()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLocation()
        updateWeatherForLocation()

        setupCollectionView()
        
        
        
    }
    
    @objc func refreshPage() {
        print("REFRESH")
//        updateWeatherForLocation()
        
        // TODO: - Analyze weather and find outfits matching those conditions
        
        analyzeWeather { (successful, outfits) in
            if successful {
                print("...successfully analyzed weather and returned outfits")
                self.savedOutfits = outfits
                self.collectionView.reloadData()
                self.refresher?.endRefreshing()
            } else {
                print("...Error analyzing weather and returning outfits")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshPage()
    }
    
    // MARK: - Weather Analyzing
    func analyzeWeather(completion: (Bool, [Outfit]) -> Void) {
        /*
         Analyze the weather and find outfits that match it
         
         -> Currently returns all saved outfits
         
         */
        
        guard let weather = self.weather else { return }
        
        var discoverOutfits: [Outfit] = []
        
        
        // Analyze saved outfits
        coreDataManager.loadOutfits { (successfully, outfits) in
            if successfully {
                for outfit in outfits {
                    if outfit.minTemp != nil && outfit.maxTemp != nil {
                        if let minTemp = Double(outfit.minTemp!), let maxTemp = Double(outfit.maxTemp!) {
                            if weather.main.temp > minTemp && weather.main.temp < maxTemp {
                                print("...Temperautre condition met")
                                discoverOutfits.append(outfit)
                            }
                        }
                    }
                }
                completion(successfully, discoverOutfits)
            } else {
                completion(false, [])
            }
        }
        
        // Create outfits
        
        
        
        
        
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDiscoverSegue" {
            let dest = segue.destination as! CategoryViewController
            dest.navigationItem.title = discover.selectedCategory?.description
            dest.view.backgroundColor = discover.selectedCategory?.image
        } else if segue.identifier == "showWeatherSegue" {
            let dest = segue.destination as! WeatherViewController
            dest.navigationItem.title = "Weather"
            dest.Weather = self.weather
        }
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCollectionViewCell.identifier, for: indexPath) as! DiscoverCollectionViewCell
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedItemCollectionViewCell.identifier, for: indexPath) as! SavedItemCollectionViewCell
            
            cell.savedOutfits = savedOutfits
            cell.collectionView.reloadData()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseidentifier", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            // Discover section
            return CGSize(width: collectionView.frame.size.width, height: (collectionView.frame.height - (2 * headerHeight)) * discoverSavedRatio)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: (collectionView.frame.height - (2 * headerHeight)) * (1 - discoverSavedRatio))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier, for: indexPath) as! sectionHeaderReuseableView
        header.headerTitle.text = self.sections[indexPath.section]
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
    

    // MARK: - Location and Weather
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            print("locations is not empty and current location is nil, updating location")
            self.coordinates = locations.first
            self.locationManager.stopUpdatingLocation()
            self.updateWeatherForLocation()
            // TODO: - update weather information
            
        }
    }
    
    // Location
    func setupLocation() {
        print("Setting up location")
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func updateWeatherForLocation() {
        // Check if coordinates has a value, else return
        
        print("UPDATING LOCATION AND WEATHER")
        guard let coordinates = self.coordinates else { return }
        
        // Get the longitude and latitude values
        let longitude = coordinates.coordinate.longitude
        let latitude = coordinates.coordinate.latitude
        
        // Create url for api request
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=220d7f41d643c19c77f1ba5f4d96ed60&units=metric") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else { return }
            
            var json: currentWeather?
            do {
                json = try JSONDecoder().decode(currentWeather.self, from: data)
            } catch {
                print("Error: \(error)")
            }
            
            // Safely unwrap the json file and append to models
            guard let result = json else { return }
            
            self.weather = result
            
            
            // reload tableView
            DispatchQueue.main.async {
                // Do something here
                self.weatherImage.image = result.weather[0].getImage()
                self.temperatureLabel.text = "\(Int(result.main.temp))°C"
                self.descriptionLabel.text = "\(result.weather[0].main)"
                self.locationLabel.text = " \(result.name)"
                self.rangeLabel.text = "\(Int(result.main.temp_min))°C / \(Int(result.main.temp_max))°C"
                self.analyzeWeather { (successful, outfits) in
                    if successful {
                        self.savedOutfits = outfits
                        self.collectionView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
    
    
}






// MARK: - Extension: Setup Functions
extension DiscoverViewController {
    
    
    // MARK: - CollectionView
    fileprivate func setupCollectionView() {
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceVertical = true
        
        
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseidentifier")
        self.collectionView.register(SavedItemCollectionViewCell.nib(), forCellWithReuseIdentifier: SavedItemCollectionViewCell.identifier)
        self.collectionView.register(DiscoverCollectionViewCell.nib(), forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier)
        
        self.collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        
        self.refresher = UIRefreshControl()
        self.refresher?.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        self.collectionView.refreshControl = self.refresher
    }
    
    
    // MARK: - NavigationBar
    fileprivate func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        
        let titleViewWidth: CGFloat = 200
        let titleViewHeight: CGFloat = 44
        
        let labelRatio: CGFloat = 0.4
        
        
        // Define the height and width of the customTitleView
        customTitleView.widthAnchor.constraint(equalToConstant: titleViewWidth).isActive = true
        customTitleView.heightAnchor.constraint(equalToConstant: titleViewHeight).isActive = true
        
        // Add a tap gesture recognizer to the title view to show a detailed view of the weather
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleViewTapped))
        customTitleView.addGestureRecognizer(tapGesture)
        
        // Add the weather image to the title view, and define constraints
        customTitleView.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.widthAnchor.constraint(equalToConstant: titleViewHeight).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: titleViewHeight).isActive = true
        weatherImage.centerYAnchor.constraint(equalTo: customTitleView.centerYAnchor).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: customTitleView.leadingAnchor, constant: 0).isActive = true
        
        // Any weather image setups done here
        weatherImage.contentMode = .scaleAspectFit
//        weatherImage.backgroundColor = .cyan
        
        
        // Add the temperature label to the titleView and define constraints
        customTitleView.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.heightAnchor.constraint(equalToConstant: titleViewHeight * 0.7).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: (titleViewWidth - titleViewHeight) * labelRatio).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: customTitleView.topAnchor).isActive = true
        
        // Any temperature label setup done here
        temperatureLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
//        temperatureLabel.backgroundColor = .systemPink
        
        // Add the range label to the titleView and define constraints
        customTitleView.addSubview(rangeLabel)
        rangeLabel.translatesAutoresizingMaskIntoConstraints = false
        rangeLabel.heightAnchor.constraint(equalToConstant: titleViewHeight * 0.3).isActive = true
        rangeLabel.widthAnchor.constraint(equalToConstant: (titleViewWidth - titleViewHeight) * labelRatio).isActive = true
        rangeLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor).isActive = true
        rangeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        
        // Any temperature label setup done here
        rangeLabel.font = UIFont.systemFont(ofSize: 11, weight: .ultraLight)
//        rangeLabel.backgroundColor = .orange
        
        // Add the description label to the titleView and define any constraints
        customTitleView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.heightAnchor.constraint(equalToConstant: titleViewHeight * 0.7).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: (titleViewWidth - titleViewHeight) * (1 - labelRatio)).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: customTitleView.topAnchor).isActive = true
        
        // Any description label setup done here
//        descriptionLabel.backgroundColor = .systemPink
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        customTitleView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.heightAnchor.constraint(equalToConstant: titleViewHeight * 0.3).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        
//        locationLabel.backgroundColor = .red
        locationLabel.font = UIFont.systemFont(ofSize: 13, weight: .ultraLight)
        
        
        
        
        // Add the custom titleView to the navigationItem titleView, and set title
        self.navigationItem.titleView = customTitleView
        self.navigationItem.title = "Todays Outfit's"
    }
    
    @objc func titleViewTapped() {
        print("Show full temperature desc")
        self.performSegue(withIdentifier: "showWeatherSegue", sender: self)
    }
}

