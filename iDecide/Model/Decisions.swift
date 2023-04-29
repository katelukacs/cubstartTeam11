//
//  Decision.swift
//  iDecide
//
//  Created by Kate Lukacs on 25/04/23.
//

import Foundation

class Decisions: ObservableObject {
    @Published var items = [DecisionItem]()
    
    init() {
        items = []
    }
}
