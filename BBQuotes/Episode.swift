//
//  Episode.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 06/06/2025.
//

import Foundation
//בונים מערכת שתפענח את הנתונים הבאים מקובץ גייסון
struct Episode: Decodable {
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    
    var seasonEpisode: String {
        "Season \(episode / 100) Episode \(episode % 100)"
    }
}
