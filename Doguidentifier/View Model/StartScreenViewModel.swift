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

	var breedListToController: (() -> Void) = {}

	var imageListToController: (() -> Void) = {}

	private(set) var breedList: [String: [String]]! {
		didSet {
			updateBreedList()
			self.breedListToController()
		}
	}

	private(set) var imageList: [String: String]! {
		didSet {
			if self.imageList.count == self.imageAmountRequested {
				self.imageAmountRequested = 0
				self.imageListToController()
			} else {
				requestImages()
			}
		}
	}

	var imageAmountRequested = 0

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
					return
				}
			case .failure(let error):
				print(error)
				return
			}
		}
	}

	func fetchBreedList() -> [BreedList]? {
		let fetch = BreedList.fetchRequest() as NSFetchRequest<BreedList>
		var foundList: [BreedList]?
		do {
			foundList = try dataContext.fetch(fetch)
			if foundList?[0].list?.count == 0 {
				foundList = nil
			}
		} catch {
			fatalError("Unable to FETCH BREED LIST DATA from data model!")
		}

		return foundList
	}

	func updateBreedList() {

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

	func getBreedImages(quantity: Int) {

		self.imageList = [:]
		self.imageAmountRequested = quantity

		requestImages()

//		if let breedList = fetchBreedList()?[0] {
//
//			for index in 0..<quantity {
//
//				var breedName = ""
//
//				if let chosenBreed = breedList.list?.randomElement() {
//
//					let masterBreed = chosenBreed.key
//					var subBreed = ""
//					breedName = masterBreed
//
//					if chosenBreed.value.count != 0 {
//
//						subBreed = chosenBreed.value.randomElement()!
//						breedName += "-" + subBreed
//
//						ServiceAPI.request(router: RouterAPI.getSubBreedImage(
//							master: masterBreed,
//							sub: subBreed
//						)) { result in
//
//							switch result {
//							case .success(let data):
//								do {
//									if let validData = data {
//										let decodedMessage = try JSONDecoder().decode(GetImage.self, from: validData)
//										self.imageList[breedName] = decodedMessage.message
//									}
//								} catch {
//									print(error)
//									return
//								}
//							case .failure(let error):
//								print(error)
//							}
//						}
//					} else {
//
//						ServiceAPI.request(router: RouterAPI.getMasterBreedImage(master: masterBreed)) { result in
//
//							switch result {
//							case .success(let data):
//								do {
//									if let validData = data {
//										let decodedMessage = try JSONDecoder().decode(GetImage.self, from: validData)
//										self.imageList[breedName] = decodedMessage.message
//									}
//								} catch {
//									print(error)
//									return
//								}
//							case .failure(let error):
//								print(error)
//							}
//						}
//					}
//				}
//
//			}
//
//		} else {
//			print("UNABLE to get BREED LIST from DATA")
//		}
	}

	private func requestImages() {
		if let breedList = fetchBreedList()?[0] {

			var breedName = ""

			if let chosenBreed = breedList.list?.randomElement() {

				let masterBreed = chosenBreed.key
				var subBreed = ""
				breedName = masterBreed

				if chosenBreed.value.count != 0 {

					subBreed = chosenBreed.value.randomElement()!
					breedName += "-" + subBreed

					ServiceAPI.request(router: RouterAPI.getSubBreedImage(
						master: masterBreed,
						sub: subBreed
					)) { result in

						switch result {
						case .success(let data):
							do {
								if let validData = data {
									let decodedMessage = try JSONDecoder().decode(GetImage.self, from: validData)
									self.imageList[breedName] = decodedMessage.message
								}
							} catch {
								print(error)
								return
							}
						case .failure(let error):
							print(error)
						}
					}
				} else {

					ServiceAPI.request(router: RouterAPI.getMasterBreedImage(master: masterBreed)) { result in

						switch result {
						case .success(let data):
							do {
								if let validData = data {
									let decodedMessage = try JSONDecoder().decode(GetImage.self, from: validData)
									self.imageList[breedName] = decodedMessage.message
								}
							} catch {
								print(error)
								return
							}
						case .failure(let error):
							print(error)
						}
					}
				}
			}

		} else {
			print("UNABLE to get BREED LIST from DATA")
		}
	}

}
