//
//  DoguidentifierTests.swift
//  DoguidentifierTests
//
//  Created by Pedro Henrique Costa on 04/02/21.
//

import XCTest
@testable import Doguidentifier

class APITests: XCTestCase {

	func testRequest_RequestFailedBreedRequest() throws {
		//Given
		let mockSession = URLSessionMock()
		let errorDescription = "The operation couldn’t be completed. (DoguidentifierTests.ErrorMock error 0.)."
		mockSession.testError = ErrorMock.testError(desc: errorDescription)

		let expect = expectation(description: "Failed Request in Getting All Dog Breeds")

		//When
		ServiceAPI.request(router: RouterAPI.getBreeds, session: mockSession) { result in
			switch result {
			case .success(let data):
				print(data as Any)
			case .failure(let error):
				XCTAssertEqual("Could not run request because: \(errorDescription)", error.localizedDescription)
				expect.fulfill()
			}
		}

		wait(for: [expect], timeout: 10)
	}

	func testRequest_NoResponseBreedRequest() throws {

		//Given
		let mockSession = URLSessionMock()

		let expect = expectation(description: "No Response in Getting All Dog Breeds")

		//When
		ServiceAPI.request(router: RouterAPI.getBreeds, session: mockSession) { result in
			switch result {
			case .success(let data):
				print(data as Any)
			case .failure(let error):
				XCTAssertEqual("The Request returned status code 404, the route was not found.", error.localizedDescription)
				expect.fulfill()
			}
		}

		wait(for: [expect], timeout: 10)
	}

	func testRequest_BadRequestBreedRequest() throws {

		//Given
		let mockSession = URLSessionMock()
		mockSession.testResponse = HTTPResponseMock(statusCode: 400)

		let expect = expectation(description: "Bad Request in Getting All Dog Breeds")

		//When
		ServiceAPI.request(router: RouterAPI.getBreeds, session: mockSession) { result in
			switch result {
			case .success(let data):
				print(data as Any)
			case .failure(let error):
				XCTAssertEqual("The Request returned status code 400, Bad Request.", error.localizedDescription)
				expect.fulfill()
			}
		}

		wait(for: [expect], timeout: 10)
	}

	func testRequest_NotFoundBreedRequest() throws {

		//Given
		let mockSession = URLSessionMock()
		mockSession.testResponse = HTTPResponseMock(statusCode: 404)

		let expect = expectation(description: "Didn't Find All Dog Breeds")

		//When
		ServiceAPI.request(router: RouterAPI.getBreeds, session: mockSession) { result in
			switch result {
			case .success(let data):
				print(data as Any)
			case .failure(let error):
				XCTAssertEqual("The Request returned status code 404, the route was not found.", error.localizedDescription)
				expect.fulfill()
			}
		}

		wait(for: [expect], timeout: 10)
	}

	func testRequest_UnknownErrorBreedRequest() throws {

		//Given
		let mockSession = URLSessionMock()
		let errorStatusCode = 555
		mockSession.testResponse = HTTPResponseMock(statusCode: errorStatusCode)

		let expect = expectation(description: "Unknown Error in Getting All Dog Breeds")

		//When
		ServiceAPI.request(router: RouterAPI.getBreeds, session: mockSession) { result in
			switch result {
			case .success(let data):
				print(data as Any)
			case .failure(let error):
				XCTAssertEqual("The Request returned status code \(errorStatusCode), unknown meaning.", error.localizedDescription)
				expect.fulfill()
			}
		}

		wait(for: [expect], timeout: 10)
	}

	func testRequest_BreedRequestValidURL() throws {

		//Given
		let url = URL(string: "https://dog.ceo/api/breeds/list/all")
		let mockSession = URLSessionMock()
		mockSession.testResponse = HTTPResponseMock(statusCode: 200)

		let expect = expectation(description: "Getting All Dog Breeds")

		//When
		ServiceAPI.request(router: RouterAPI.getBreeds, session: mockSession) { _ in
			XCTAssertEqual(url, mockSession.lastURL)
			expect.fulfill()
		}

		wait(for: [expect], timeout: 10)

	}

    func testRequest_ImageRequestValidURL() throws {

        //Given
		let url = URL(string: "https://dog.ceo/api/breed/bulldog/french/images/random")
		let mockSession = URLSessionMock()
		mockSession.testResponse = HTTPResponseMock(statusCode: 200)

		let expect = expectation(description: "Getting French Bulldog Image")

		//When
		ServiceAPI.request(router: RouterAPI.getImage(master: "bulldog", sub: "french"), session: mockSession) { _ in
			XCTAssertEqual(url, mockSession.lastURL)
			expect.fulfill()
		}

		wait(for: [expect], timeout: 10)
    }

}
