//
//  DiscoverViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 20.11.20.
//

import UIKit

class DiscoverViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let headerHeight: CGFloat = 42
    let discoverSavedRatio: CGFloat = 0.15
    let sections = ["Discover", "Saved"]
    
    let titleViewHeight: CGFloat = 55
    let titleViewWidth: CGFloat = 218
    
    // MARK: - NavigationBar
    let customTitleView = UIView()
    let weatherImage = UIImageView()
    let temperatureLabel = UILabel()
    let rangeLabel = UILabel()
    let descriptionLabel = UILabel()
    let locationLabel = UILabel()
    
    fileprivate func setupNavigationBar() {
        let titleViewWidth: CGFloat = 200
        let titleViewHeight: CGFloat = 44
        
        let labelRatio: CGFloat = 0.5
        
        
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
        weatherImage.leadingAnchor.constraint(equalTo: customTitleView.leadingAnchor, constant: 32).isActive = true
        
        // Any weather image setups done here
        weatherImage.contentMode = .scaleAspectFit
        weatherImage.backgroundColor = .cyan
        
        
        // Add the temperature label to the titleView and define constraints
        customTitleView.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.heightAnchor.constraint(equalToConstant: titleViewHeight * 0.7).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: (titleViewWidth - titleViewHeight) * labelRatio).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: customTitleView.topAnchor).isActive = true
        
        // Any temperature label setup done here
        temperatureLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        temperatureLabel.backgroundColor = .systemPink
        
        // Add the range label to the titleView and define constraints
        customTitleView.addSubview(rangeLabel)
        rangeLabel.translatesAutoresizingMaskIntoConstraints = false
        rangeLabel.heightAnchor.constraint(equalToConstant: titleViewHeight * 0.3).isActive = true
        rangeLabel.widthAnchor.constraint(equalToConstant: (titleViewWidth - titleViewHeight) * labelRatio).isActive = true
        rangeLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor).isActive = true
        rangeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
        
        // Any temperature label setup done here
        rangeLabel.font = UIFont.systemFont(ofSize: 13, weight: .ultraLight)
        rangeLabel.backgroundColor = .orange
        
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
//        self.performSegue(withIdentifier: "showFullWeatherSegue", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()

        // Do any additional setup after loading the view.
//        self.navigationItem.title = "Discover"
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceVertical = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseidentifier")
        self.collectionView.register(SavedItemCollectionViewCell.nib(), forCellWithReuseIdentifier: SavedItemCollectionViewCell.identifier)
        self.collectionView.register(DiscoverCollectionViewCell.nib(), forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier)
        
        self.collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCollectionViewCell.identifier, for: indexPath) as! DiscoverCollectionViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedItemCollectionViewCell.identifier, for: indexPath) as! SavedItemCollectionViewCell
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
    

}
