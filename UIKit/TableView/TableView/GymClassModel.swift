//
//  GymClassModel.swift
//  TableView
//
//  Created by Dawid Grazawski on 26/06/2025.
//

import Foundation
import UIKit


struct GymClassModel {
    let className: String
    let day: String
    let time: String
    let duration: String
    let trainerName: String
    let trainerPhoto: UIImage
    var isRegistered: Bool
    
    static let mockupData: [GymClassModel] = [
        GymClassModel(className: "Calisthenics", day: "Monday 23 June 2025", time: "11:00", duration: "55", trainerName: "Steven Dumbbell", trainerPhoto: Images.trainer1, isRegistered: true),
        GymClassModel(className: "Spinning", day: "Monday 23 June 2025", time: "12:00", duration: "40", trainerName: "Ash Bicycle", trainerPhoto: Images.trainer2, isRegistered: false),
        GymClassModel(className: "Yoga - Beginners", day: "Monday 23 June 2025", time: "13:00", duration: "30", trainerName: "Christian Monk", trainerPhoto: Images.trainer3, isRegistered: false),
        GymClassModel(className: "Olympic weightlifting", day: "Tuesday 24 June 2025", time: "09:00", duration: "60", trainerName: "Ariel Weightlifter", trainerPhoto: Images.trainer4, isRegistered: false),
        GymClassModel(className: "Calisthenics", day: "Tuesday 24 June 2025", time: "10:00", duration: "35", trainerName: "Christian Barbell", trainerPhoto: Images.trainer5, isRegistered: false),
        GymClassModel(className: "Yoga - Advanced", day: "Tuesday 24 June 2025", time: "11:00", duration: "40", trainerName: "Random Cat", trainerPhoto: Images.trainer6, isRegistered: false),
        GymClassModel(className: "Quidditch", day: "Wednesday 25 June 2025", time: "11:00", duration: "55", trainerName: "Harry Potter", trainerPhoto: Images.trainer7, isRegistered: false),
        GymClassModel(className: "Swimming", day: "Wednesday 25 June 2025", time: "14:00", duration: "60", trainerName: "Private Ryan", trainerPhoto: Images.trainer8, isRegistered: false),
        GymClassModel(className: "Gymnastics", day: "Wednesday 25 June 2025", time: "15:00", duration: "30", trainerName: "Seth Bodyweight", trainerPhoto: Images.trainer9, isRegistered: false),
        GymClassModel(className: "Running", day: "Friday 27 June 2025", time: "08:00", duration: "60", trainerName: "Frodo Baggins", trainerPhoto: Images.trainer10, isRegistered: false),
    ]
}


struct Images {
    static let trainer1 = UIImage(named: "trainer2")!
    static let trainer2 = UIImage(named: "trainer3")!
    static let trainer3 = UIImage(named: "trainer4")!
    static let trainer4 = UIImage(named: "trainer5")!
    static let trainer5 = UIImage(named: "trainer6")!
    static let trainer6 = UIImage(named: "trainer7")!
    static let trainer7 = UIImage(named: "trainer8")!
    static let trainer8 = UIImage(named: "trainer9")!
    static let trainer9 = UIImage(named: "trainer10")!
    static let trainer10 = UIImage(named: "trainer11")!
}
