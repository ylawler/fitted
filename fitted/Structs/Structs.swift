//
//  Structs.swift
//  fitted
//
//  Created by Yannick Lawler on 25.11.20.
//

import UIKit


public struct Mood: Equatable {
    let name: String
}

public struct Weather: Equatable {
    let name: String
}

public struct Category: Equatable {
    let name: String
}


let Hats = Category(name: "Hats")
let Neck = Category(name: "Neck")
let UpperBody = Category(name: "Upper Body")
let Waist = Category(name: "Waist")
let Legs = Category(name: "Legs")
let Feet = Category(name: "Feet")
let Jewelry = Category(name: "Jewelry")
let Accessories = Category(name: "Accessories")


public let Categories = [Hats, Neck, UpperBody, Waist, Legs, Feet, Jewelry, Accessories]

let comfortable = Mood(name: "comfortable")
let Work = Mood(name: "Work")
let Bloated = Mood(name: "Bloated")
let Fancy = Mood(name: "Fancy")
let Date = Mood(name: "Date")
let Party = Mood(name: "Party")
let Chill = Mood(name: "Chill")

let Sunny = Weather(name: "Sunny")
let Rainy = Weather(name: "Rainy")
let Cloudy = Weather(name: "Cloudy")


public let Moods: [Mood] = [comfortable, Work, Bloated, Fancy, Date, Party, Chill]
public let Weathers: [Weather] = [Sunny, Rainy, Cloudy]
