//
//  DecisionItem.swift
//  iDecide
//
//  Created by Kate Lukacs on 28/04/23.
//

import Foundation

struct DecisionItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let decide: Int
}


