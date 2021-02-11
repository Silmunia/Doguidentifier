//
//  TestMockData.swift
//  DoguidentifierTests
//
//  Created by Pedro Henrique Costa on 10/02/21.
//

import Foundation

class TestMockData {
	var testData: Data?
	var testError: Error?
	var testResponse: HTTPURLResponse?

	init(data: Data?, error: Error?, response: HTTPURLResponse?) {
		self.testData = data
		self.testError = error
		self.testResponse = response
	}
}
