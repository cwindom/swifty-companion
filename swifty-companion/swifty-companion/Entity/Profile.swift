//
//  Profile.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 13.06.2022.
//

import Foundation

public struct Profile {
    
    //в ячейке
    var name: String?
    var fullName: String?
    var level: Float = 0
    var availability: String = ""
    var wallet: String = ""
    var points: String = ""
    
    var projects: [Project]?
    var contacts: Contacts?

}
