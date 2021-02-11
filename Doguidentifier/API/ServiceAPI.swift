//
//  ServiceAPI.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 10/02/21.
//

import Foundation

struct ServiceAPI {

	static func request(
		router: RouterAPI,
		session: URLSession = URLSession.shared,
		completion: @escaping (Result<Data?, ErrorAPI>) -> Void
	) {

		guard let request = router.urlRequest else {
			completion(.failure(ErrorAPI.malformedURLRequest(url: router.url?.absoluteString ?? "nil")))
			return
		}

		let dataTask = session.dataTask(with: request) { data, response, error in

			if let error = error {
				completion(.failure(.requestFailed(description: error.localizedDescription)))
				return
			}

			guard let response = response as? HTTPURLResponse else {
				completion(.failure(.notFound))
				return
			}

			switch response.statusCode {
			case 200, 201:
				completion(.success(data))
			case 400:
				completion(.failure(.badRequest))
			case 404:
				completion(.failure(.notFound))
			default:
				completion(.failure(.unknownError(statusCode: response.statusCode)))
			}
		}

		dataTask.resume()
	}
}
