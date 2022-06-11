//
//  SearchInteractor.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation
import AuthenticationServices

final class SearchInteractor {
    
    weak var output: SearchInteractorOutput?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
}

extension SearchInteractor: SearchInteractorInput {}


struct CursusUser: Codable {
    let level: Double
    let skills: [Skills]
    let cursus: Cursus
}

struct Skills: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case level
    }
    
    let name: String
    let level: Double
}

struct Cursus: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    let id: Int
    let name: String
}
