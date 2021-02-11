//
//  BreedListDecoding.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 11/02/21.
//

import Foundation

struct GetBreedList: Codable {
	let message: [String: [String]]
	let status: String
}
