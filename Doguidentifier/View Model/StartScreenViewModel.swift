//
//  StartScreenViewModel.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 11/02/21.
//

import UIKit

class StartScreenViewModel: NSObject {

	// swiftlint:disable force_cast
	let dataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	// swiftlint:enable force_cast

	var bindStartScreenVMToController: (() -> Void) = {}

	private(set) var breedList: [String: [String]]! {
		didSet {
			self.bindStartScreenVMToController()
		}
	}

	override init() {
		super.init()

		getAllBreedsList()
	}

	func getAllBreedsList() {

		ServiceAPI.request(router: RouterAPI.getBreeds) { result in
			switch result {
			case .success(let data):
				do {
					if let validData = data {
						let decodedMessage = try JSONDecoder().decode(GetBreedList.self, from: validData)
						self.breedList = decodedMessage.message
					}
				} catch {
					print(error)
				}
			case .failure(let error):
				print(error)
			}
		}
	}

}
