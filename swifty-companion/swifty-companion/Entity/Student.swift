//
//  Student.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 11.06.2022.
//

import Foundation
import UIKit

public class Coalition {
    
    let color: UIColor
    let name: String
    let score: Int
    
    public init(color: UIColor, name: String, score: Int) {
        
        self.color = color
        self.name = name
        self.score = score
    }
}

public class Student {
    
    var login: String
    var fullName: String
    var wallet: String
    var availability: String
    let coalition: Coalition
    let level: Float
    let evaluationPoints: Int
    
    init(login: String,
         fullName: String,
         wallet: String,
         availability: String,
         coalition: Coalition,
         level: Float,
         evaluationPoints: Int) {
        
        self.login = login
        self.fullName = fullName
        self.wallet = wallet
        self.availability = availability
        self.coalition = coalition
        self.level = level
        self.evaluationPoints = evaluationPoints
    }
}
