//
//  URLSessionMock.swift
//  DoguidentifierTests
//
//  Created by Pedro Henrique Costa on 10/02/21.
//

import Foundation
@testable import Doguidentifier

class URLSessionMock: URLSession {
	var testData: Data?
	var testError: Error?
	var testResponse: HTTPURLResponse?
	var lastURL: URL?
	var dataTask: DataTaskMock?

	override func dataTask(
		with request: URLRequest,
		completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		lastURL = request.url
		let testMock = TestMockData(data: testData, error: testError, response: testResponse)
		let newDataTask = DataTaskMock(mockData: testMock, completion: completionHandler)
		dataTask = newDataTask
		return newDataTask
	}

}
