//
//  DataTaskMock.swift
//  DoguidentifierTests
//
//  Created by Pedro Henrique Costa on 10/02/21.
//

import Foundation
@testable import Doguidentifier

class DataTaskMock: URLSessionDataTask {
	var mockData: TestMockData?

	var calledResume = false
	var completion: (Data?, URLResponse?, Error?) -> Void

	init(mockData: TestMockData? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
		self.completion = completion
		self.mockData = mockData
	}

	override func resume() {
		calledResume = true
		completion(mockData?.testData, mockData?.testResponse, mockData?.testError)
	}
}
