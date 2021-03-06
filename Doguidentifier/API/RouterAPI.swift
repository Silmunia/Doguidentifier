//
//  RouterAPI.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 10/02/21.
//

import Foundation

enum RouterAPI {

	case getBreeds
	case getMasterBreedImage(master: String)
	case getSubBreedImage(master: String, sub: String)

	var scheme: String {
		switch self {
		case .getBreeds, .getMasterBreedImage, .getSubBreedImage:
			return "https"
		}
	}

	var host: String {
		switch self {
		case .getBreeds, .getMasterBreedImage, .getSubBreedImage:
			return "dog.ceo"
		}
	}

	var path: String {
		switch self {
		case .getBreeds:
			return "/api/breeds/list/all"
		case .getMasterBreedImage(let master):
			return "/api/breed/\(master)/images/random"
		case .getSubBreedImage(let master, let sub):
			return "/api/breed/\(master)/\(sub)/images/random"
		}
	}

	var method: String {
		switch self {
		case .getBreeds, .getMasterBreedImage, .getSubBreedImage:
			return "GET"
		}
	}

	var url: URL? {
		var components = URLComponents()
		components.scheme = self.scheme
		components.host = self.host
		components.path = self.path
		return components.url
	}

	var urlRequest: URLRequest? {
		guard let validURL = self.url else {
			return nil
		}

		var request = URLRequest(url: validURL)
		request.httpMethod = self.method
		return request
	}
}
