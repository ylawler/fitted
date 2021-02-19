//
//  Structs.swift
//  fitted
//
//  Created by Yannick Lawler on 25.11.20.
//

import UIKit


class currentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    
    func printWeather() {
        print("--------------- COORD ---------------")
        coord.display()
        
        print("-------------- WEATHER --------------")
        for w in weather {
            w.display()
        }
        print("--------------------------------------")
        
        print()
        print("base : \(base)")
        print()
        
        print("---------------- MAIN ----------------")
        main.display()
        
        print("---------------- WIND ----------------")
        wind.display()
        
        print("--------------- CLOUDS ---------------")
        clouds.display()
        print("--------------------------------------")
        print()
        print("dt : \(dt)")
        print()
        
        print("----------------- SYS ----------------")
        sys.display()
        print("--------------------------------------")
        print()
        print("timezone : \(timezone)")
        print()
        print("--------------------------------------")
        print()
        print("id : \(id)")
        print()
        print("--------------------------------------")
        print()
        print("name : \(name)")
        print()
        print("--------------------------------------")
        print()
        print("cod : \(cod)")
        print()
        print("--------------------------------------")
    }
 
}


class Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    func getImage() -> UIImage {
        var iconImage = UIImage()
        let url = "https://openweathermap.org/img/wn/\(self.icon)@2x.png"
        
        guard let iconURL = URL(string: url) else { return iconImage }
        
        if let data = try? Data(contentsOf: iconURL) {
            iconImage = UIImage(data: data)!
        }
        return iconImage
    }
    
    func display() {
        print("weather id : \(id)")
        print("main       : \(main)")
        print("desc       : \(description)")
        print("icon       : \(icon)")
    }
    
}

class Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
    
    func display() {
        print("temp       : \(temp)")
        print("feels like : \(feels_like)")
        print("temp min   : \(temp_min)")
        print("temp max   : \(temp_max)")
        print("pressure   : \(pressure)")
        print("humidity   : \(humidity)")
    }
}

class Wind: Codable {
    let speed: Double
    let deg: Double
    
    func display() {
        print("speed : \(speed)")
        print("deg   : \(deg)")
    }
    
}

class Clouds: Codable {
    let all: Int
    
    func display() {
        print("all : \(all)")
    }
}

class Sys: Codable {
    let type: Int
    let id: Int
    //    let message: Float
    let country: String
    let sunrise: Double
    let sunset: Double
    
    
    func display() {
        print("type    : \(type)")
        print("Sys id  : \(id)")
        print("country : \(country)")
        print("sunrise : \(sunrise)")
        print("sunset  : \(sunset)")
    }
    
}

class Coord: Codable {
    let lon: Float
    let lat: Float
    
    func display() {
        print("lon : \(lon)")
        print("lat : \(lat)")
    }
}


struct discoverCategory {
    let description: String
    let image: UIColor
}

class Discover {
    
    let categories: [discoverCategory] = [
        discoverCategory(description: "Mood", image: .blue),
        discoverCategory(description: "Style", image: .systemPink),
        discoverCategory(description: "Song", image: .cyan),
        discoverCategory(description: "Random", image: .systemGreen),
        discoverCategory(description: "hello", image: .systemTeal)
    ]
    
    var selectedCategory: discoverCategory? = nil
    
    init() {
        
    }
    
    func getCount() -> Int {
        return categories.count
    }
    
    func getDiscoverText(forIndexPath: IndexPath) -> String? {
        
        if forIndexPath.item <= categories.count {
            return categories[forIndexPath.item].description
        } else {
            return nil
        }
    }
    
    func getDiscoverCategory(forIndexPath: IndexPath) -> discoverCategory? {
        
        if forIndexPath.item <= categories.count {
            return categories[forIndexPath.item]
        } else {
            return nil
        }
    }
    
    
    func selectedCategory(forIndexPath: IndexPath) {
        if let discoverText = getDiscoverCategory(forIndexPath: forIndexPath) {
            self.selectedCategory = discoverText
        }
    }
    
    
}


public struct fittedMood: Equatable {
    let name: String
}

public struct fittedWeather: Equatable {
    let name: String
}

public struct fittedCategory: Equatable {
    let name: String
}


let Hats = fittedCategory(name: "Hats")
let Neck = fittedCategory(name: "Neck")
let UpperBody = fittedCategory(name: "Upper Body")
let Waist = fittedCategory(name: "Waist")
let Legs = fittedCategory(name: "Legs")
let Feet = fittedCategory(name: "Feet")
let Jewelry = fittedCategory(name: "Jewelry")
let Accessories = fittedCategory(name: "Accessories")


public let fittedCategories: [fittedCategory] = [Hats, Neck, UpperBody, Waist, Legs, Feet, Jewelry, Accessories]

let Comfortable = fittedMood(name: "Comfortable")
let Work = fittedMood(name: "Work")
let Bloated = fittedMood(name: "Bloated")
let Fancy = fittedMood(name: "Fancy")
let Date = fittedMood(name: "Date")
let Party = fittedMood(name: "Party")
let Chill = fittedMood(name: "Chill")

let Sunny = fittedWeather(name: "Sunny")
let Rainy = fittedWeather(name: "Rainy")
let Cloudy = fittedWeather(name: "Cloudy")


public let fittedMoods: [fittedMood] = [Comfortable, Work, Bloated, Fancy, Date, Party, Chill]
public let fittedWeathers: [fittedWeather] = [Sunny, Rainy, Cloudy]
