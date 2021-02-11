//
//  HTTPResponseMock.swift
//  DoguidentifierTests
//
//  Created by Pedro Henrique Costa on 11/02/21.
//

import Foundation

class HTTPResponseMock: HTTPURLResponse {
	init(statusCode: Int) {
		super.init(url: URL(string: "https://fake.com")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
