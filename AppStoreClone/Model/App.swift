//
//  App.swift
//  AppStore
//
//  Created by Leonardo Almeida on 22/11/22.
//

import Foundation

struct App: Decodable {
    let id: Int
    let nome: String
    let empresa: String
    let avaliacao: String?
    let iconeUrl: String
    let screenshotUrls: [String]?
}
