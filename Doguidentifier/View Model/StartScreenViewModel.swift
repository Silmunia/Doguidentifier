//
//  StartScreenViewModel.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 11/02/21.
//

import UIKit
import CoreData

class StartScreenViewModel: NSObject {

	// swiftlint:disable force_cast
	let dataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	// swiftlint:enable force_cast

	var bindBreedListToController: (() -> Void) = {}

	private(set) var breedList: [String: [String]]! {
		didSet {
			updateBreedList()
			self.bindBreedListToController()
		}
	}

	var imageAmountRequested = 0

	override init() {
		super.init()

		getAllBreedsList()
	}

	private func getAllBreedsList() {

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
					return
				}
			case .failure(let error):
				print(error)
				return
			}
		}
	}

	private func fetchBreedList() -> [BreedList]? {
		let fetch = BreedList.fetchRequest() as NSFetchRequest<BreedList>
		var foundList: [BreedList]?
		do {
			foundList = try dataContext.fetch(fetch)
			if foundList?.count == 0 || foundList?[0].list?.count == 0 {
				foundList = nil
			}
		} catch {
			fatalError("Unable to FETCH BREED LIST DATA from data model!")
		}

		return foundList
	}

	private func updateBreedList() {

		if let savedList = fetchBreedList() {
			let foundList = savedList[0]
			foundList.list = self.breedList
		} else {
			let newList = BreedList(context: self.dataContext)
			newList.list = self.breedList
		}

		do {
			try dataContext.save()
		} catch {
			fatalError("Unable to SAVE BREED LIST DATA to data model!")
		}

	}

}
