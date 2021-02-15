//
//  GameScreenViewModel.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 11/02/21.
//

import UIKit
import CoreData

// swiftlint:disable:next type_body_length
class GameScreenViewModel: NSObject {

	// swiftlint:disable force_cast
	let dataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	// swiftlint:enable force_cast

	var bindReadyImageToController: (() -> Void) = {}

	private(set) var readyImage: (breed: String, image: UIImage)! {
		didSet {
			self.bindReadyImageToController()
		}
	}

	private(set) var rawImage: (breed: String, imageString: String)! {
		didSet {
			self.prepareImageOptions()
		}
	}

	private var breedOptions: [String]!

	private(set) var breedList: [String: [String]]! {
		didSet {
			self.requestImageToGame()
		}
	}

	override init() {
		super.init()

		updateBreedList()
	}

	private func prepareImageOptions() {

		let formatedBreed = formatBreedName(rawName: rawImage.breed)
		let loadedImage = getImageFromURL(imageURL: rawImage.imageString)!

		self.breedOptions = getRandomBreedOptions(exception: rawImage.breed)

		self.readyImage = (formatedBreed, loadedImage)
	}

	private func getRandomBreedOptions(exception: String) -> [String] {

		var tempList = breedList
		var breedCode = ""
		var options: [String] = []

		while options.count != 3 {
			if let chosenBreed = tempList?.randomElement()! {

				let master = chosenBreed.key
				breedCode += master

				if chosenBreed.value.count != 0 {

					let subBreed = chosenBreed.value.randomElement()!
					breedCode += "-\(subBreed)"
				}

				tempList?.removeValue(forKey: master)

				if breedCode == exception {
					continue
				} else {
					options.append(formatBreedName(rawName: breedCode))
					breedCode = ""
				}
			}
		}

		return options
	}

	func sendImageDataToGame() -> (breed: String, image: UIImage) {
		return readyImage
	}

	func sendRandomBreedsToGame() -> [String] {
		return breedOptions
	}

	private func requestImageToGame() {
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
									self.rawImage = (breedName, decodedMessage.message)
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
									self.rawImage = (breedName, decodedMessage.message)
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

	private func fetchBreedList() -> [BreedList]? {
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

	private func updateBreedList() {

		if let savedList = fetchBreedList() {
			let foundList = savedList[0]
			self.breedList = foundList.list
		} else {
			let newList = BreedList(context: self.dataContext)
			self.breedList = newList.list
		}

		do {
			try dataContext.save()
		} catch {
			fatalError("Unable to SAVE BREED LIST DATA to data model!")
		}

	}

	// swiftlint:disable cyclomatic_complexity
	// swiftlint:disable:next function_body_length
	private func formatBreedName(rawName: String) -> String {

		var formatedName = ""

		switch rawName {
		case "affenpinscher":
			formatedName = "Affenpinscher"
		case "african":
			formatedName = "African"
		case "airedale":
			formatedName = "Airedale"
		case "akita":
			formatedName = "Akita"
		case "appenzeller":
			formatedName = "Appenzeller"
		case "australian-shepherd":
			formatedName = "Australian Shepherd"
		case "basenji":
			formatedName = "Basenji"
		case "beagle":
			formatedName = "Beagle"
		case "bluetick":
			formatedName = "Bluetick"
		case "borzoi":
			formatedName = "Borzoi"
		case "bouvier":
			formatedName = "Bouvier"
		case "boxer":
			formatedName = "Boxer"
		case "brabancon":
			formatedName = "Brabancon"
		case "briard":
			formatedName = "Briard"
		case "buhund-norwegian":
			formatedName = "Norwegian Buhund"
		case "bulldog-boston":
			formatedName = "Boston Bulldog"
		case "bulldog-english":
			formatedName = "English Bulldog"
		case "bulldog-french":
			formatedName = "French Bulldog"
		case "bullterrier-staffordshire":
			formatedName = "Staffordshire Bull Terrier"
		case "cairn":
			formatedName = "Cairn"
		case "cattledog-australian":
			formatedName = "Australian Cattle Dog"
		case "chihuahua":
			formatedName = "Chihuahua"
		case "chow":
			formatedName = "Clumber"
		case "cockapoo":
			formatedName = "Cockapoo"
		case "collie-border":
			formatedName = "Border Collie"
		case "coonhound":
			formatedName = "Coonhound"
		case "corgi-cardigan":
			formatedName = "Welsh Corgi Cardigan"
		case "cotondetulear":
			formatedName = "Coton de Tulear"
		case "dachshund":
			formatedName = "Dachshund"
		case "dalmatian":
			formatedName = "Dalmatian"
		case "dane-great":
			formatedName = "Great Dane"
		case "deerhound-scottish":
			formatedName = "Scottish Deerhound"
		case "dhole":
			formatedName = "Dhole"
		case "dingo":
			formatedName = "Dingo"
		case "doberman":
			formatedName = "Doberman"
		case "elkhound-norwegian":
			formatedName = "Norwegian Elkhound"
		case "entlebucher":
			formatedName = "Entlebucher"
		case "eskimo":
			formatedName = "Eskimo"
		case "finnish-lapphund":
			formatedName = "Finnish Lapphund"
		case "frise-bichon":
			formatedName = "Bichon Frise"
		case "germanshepherd":
			formatedName = "German Shepherd"
		case "greyhound-italian":
			formatedName = "Italian Greyhound"
		case "groenendael":
			formatedName = "Belgian Shepherd"
		case "havanese":
			formatedName = "Havanese"
		case "hound-afghan":
			formatedName = "Afghan Hound"
		case "hound-basset":
			formatedName = "Basset Hound"
		case "hound-blood":
			formatedName = "Bloodhound"
		case "hound-english":
			formatedName = "English Hound"
		case "hound-ibizan":
			formatedName = "Ibizan Hound"
		case "hound-plott":
			formatedName = "Plott Hound"
		case "hound-walker":
			formatedName = "Walker Coonhound"
		case "husky":
			formatedName = "Husky"
		case "keeshond":
			formatedName = "Keeshond"
		case "kelpie":
			formatedName = "Kelpie"
		case "komondor":
			formatedName = "Komondor"
		case "kuvasz":
			formatedName = "Kuvasz"
		case "labrador":
			formatedName = "Labrador"
		case "leonberg":
			formatedName = "Leonberg"
		case "lhasa":
			formatedName = "Lhasa"
		case "malamute":
			formatedName = "Malamute"
		case "malinois":
			formatedName = "Malinois"
		case "maltese":
			formatedName = "Maltese"
		case "mastiff-bull":
			formatedName = "Bullmastiff"
		case "mastiff-english":
			formatedName = "English Mastiff"
		case "mastiff-tibetan":
			formatedName = "Tibetan Mastiff"
		case "mexicanhairless":
			formatedName = "Mexican Hairless"
		case "mix":
			formatedName = "Mix (No Race)"
		case "mountain-bernese":
			formatedName = "Bernese Mountain Dog"
		case "mountain-swiss":
			formatedName = "Swiss Mountain Dog"
		case "newfoundland":
			formatedName = "Newfoundland Dog"
		case "otterhound":
			formatedName = "Otterhound"
		case "ovcharka-caucasian":
			formatedName = "Caucasian Shepherd Dog"
		case "papillon":
			formatedName = "Papillon"
		case "pekinese":
			formatedName = "Pekinese"
		case "pembroke":
			formatedName = "Pembroke"
		case "pinscher-miniature":
			formatedName = "Miniature Pinscher"
		case "pitbull":
			formatedName = "Pitbull"
		case "pointer-german":
			formatedName = "German Pointer"
		case "pointer-germanlonghair":
			formatedName = "German Longhaired Pointer"
		case "pomeranian":
			formatedName = "Pomeranian"
		case "poodle-miniature":
			formatedName = "Miniature Poodle"
		case "poodle-standard":
			formatedName = "Poodle"
		case "poodle-toy":
			formatedName = "Toy Poodle"
		case "pug":
			formatedName = "Pug"
		case "puggle":
			formatedName = "Puggle"
		case "pyrenees":
			formatedName = "Pyrenees"
		case "redbone":
			formatedName = "Redbone Coonhound"
		case "retriever-chesapeake":
			formatedName = "Chesapeake Bay Retriever"
		case "retriever-curly":
			formatedName = "Curly-Coated Retriever"
		case "retriever-flatcoated":
			formatedName = "Flat-Coated Retriever"
		case "retriever-golden":
			formatedName = "Golden Retriever"
		case "ridgeback-rhodesian":
			formatedName = "Rhodesian Ridgeback"
		case "rottweiler":
			formatedName = "Rottweiler"
		case "saluki":
			formatedName = "Saluki"
		case "samoyed":
			formatedName = "Samoyed"
		case "schipperke":
			formatedName = "Schipperke"
		case "schnauzer-giant":
			formatedName = "Giant Schnauzer"
		case "schnauzer-miniature":
			formatedName = "Miniature Schnauzer"
		case "setter-english":
			formatedName = "English Setter"
		case "setter-gordon":
			formatedName = "Gordon Setter"
		case "setter-irish":
			formatedName = "Irish Setter"
		case "sheepdog-english":
			formatedName = "English Sheepdog"
		case "sheepdog-shetland":
			formatedName = "Shetland Sheepdog"
		case "shiba":
			formatedName = "Shiba"
		case "shihtzu":
			formatedName = "Shihtzu"
		case "spaniel-blenheim":
			formatedName = "King Charles Spaniel"
		case "spaniel-brittany":
			formatedName = "Brittany Spaniel"
		case "spaniel-cocker":
			formatedName = "Cocker Spaniel"
		case "spaniel-irish":
			formatedName = "Irish Spaniel"
		case "spaniel-japanese":
			formatedName = "Japanese Spaniel"
		case "spaniel-sussex":
			formatedName = "Sussex Spaniel"
		case "spaniel-welsh":
			formatedName = "Welsh Spaniel"
		case "springer-english":
			formatedName = "English Springer"
		case "stbernard":
			formatedName = "Saint Bernard Dog"
		case "terrier-american":
			formatedName = "American Terrier"
		case "terrier-australian":
			formatedName = "Australian Terrier"
		case "terrier-bedlington":
			formatedName = "Bedlington Terrier"
		case "terrier-border":
			formatedName = "Border Terrier"
		case "terrier-dandie":
			formatedName = "Dandie Dinmont Terrier"
		case "terrier-fox":
			formatedName = "Fox Terrier"
		case "terrier-irish":
			formatedName = "Irish Terrier"
		case "terrier-kerryblue":
			formatedName = "Kerry Blue Terrier"
		case "terrier-lakeland":
			formatedName = "Lakeland Terrier"
		case "terrier-norfolk":
			formatedName = "Norfolk Terrier"
		case "terrier-norwich":
			formatedName = "Norwich Terrier"
		case "terrier-patterdale":
			formatedName = "Patterdale Terrier"
		case "terrier-russel":
			formatedName = "Jack Russel Terrier"
		case "terrier-scottish":
			formatedName = "Scottish Terrier"
		case "terrier-sealyham":
			formatedName = "Sealyham Terrier"
		case "terrier-silky":
			formatedName = "Silky Terrier"
		case "terrier-tibetan":
			formatedName = "Tibetan Terrier"
		case "terrier-toy":
			formatedName = "Toy Fox Terrier"
		case "terrier-westhighland":
			formatedName = "West Highland White Terrier"
		case "terrier-wheaten":
			formatedName = "Soft-Coated Wheaten Terrier"
		case "terrier-yorkshire":
			formatedName = "Yorkshire Terrier"
		case "vizsla":
			formatedName = "Vizsla Dog"
		case "waterdog-spanish":
			formatedName = "Spanish Water Dog"
		case "weimaraner":
			formatedName = "Weimaraner Dog"
		case "whippet":
			formatedName = "Whippet Dog"
		case "wolfhound-irish":
			formatedName = "Irish Wolfhound"
		default:
			formatedName = "Error: Unknown Dog"
		}

		return formatedName
	}
	// swiftlint:enable cyclomatic_complexity

	private func getImageFromURL(imageURL: String) -> UIImage? {
		if let validURL = URL(string: imageURL) {
			do {
				let imageData = try Data(contentsOf: validURL)
				return UIImage(data: imageData)
			} catch {
				print(error)
			}
		}

		return nil
	}

}
