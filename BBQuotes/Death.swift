//
//  Death.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 24/05/2025.
//
import Foundation

struct Death: Decodable { //מפאנח גייסון
    let character: String //המידע שאנו רוצים שיוצג מגייסון
    let image: URL
    let details: String
    let lastWords: String
}
