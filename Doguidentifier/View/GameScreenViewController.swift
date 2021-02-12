//
//  GameScreenViewController.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class GameScreenViewController: UIViewController {

	private var gameScreenViewModel: GameScreenViewModel!

	private var photoCounter = (current: 99, total: 99)

	lazy var screenBackground: UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleAspectFit
		let img = UIImage(named: "GameScreenPattern")
		imgView.image = img
		return imgView
	}()

	lazy var resultQuantity: TextDisplay = {
		let text = TextDisplay(
			width: 150,
			height: 60,
			fontSize: 32,
			text: "25 / 25",
			fillColor: UIColor.dogNavy,
			borderColor: UIColor.dogPaleNavy
		)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()

	lazy var exitButton: DogButton = {
		let button = DogButton(
			width: 150,
			height: 60,
			text: "Exit",
			fontSize: 32,
			fillColor: UIColor.dogRed,
			borderColor: UIColor.dogWhite
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	lazy var dogPhoto: DogPhoto = {
		let photo = DogPhoto(photo: "TestDog1")
		photo.translatesAutoresizingMaskIntoConstraints = false
		return photo
	}()

	lazy var dogOptions: DogOptions = {
		let options = DogOptions(options: [
									"Some Dog",
									"Another Dog With a Very Big Name",
									"A Third Dog Here", "Small Dog"
		])
		options.translatesAutoresizingMaskIntoConstraints = false
		return options
	}()

	lazy var choiceResult: ChoiceResult = {
		let result = ChoiceResult()
		result.translatesAutoresizingMaskIntoConstraints = false
		return result
	}()

	lazy var loadingWarning: TextDisplay = {
		let text = TextDisplay(
			width: 280,
			height: 100,
			fontSize: 42,
			text: "Loading...",
			fillColor: UIColor.dogNavy,
			borderColor: UIColor.dogPaleNavy
		)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.barStyle = .black

		configureLayout()

		choiceResult.isHidden = true
		dogPhoto.isHidden = true
		dogOptions.isHidden = true
		super.view.backgroundColor = UIColor.dogPurple

		callToLoadImages()
    }

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	private func configureLayout() {
		self.view.addSubview(screenBackground)
		self.view.addSubview(resultQuantity)
		self.view.addSubview(exitButton)
		self.view.addSubview(dogPhoto)
		self.view.addSubview(dogOptions)
		self.view.addSubview(choiceResult)
		self.view.addSubview(loadingWarning)

		NSLayoutConstraint.activate([
			screenBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
			screenBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			screenBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			screenBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor),

			resultQuantity.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
			resultQuantity.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),

			exitButton.topAnchor.constraint(equalTo: resultQuantity.topAnchor),
			exitButton.leftAnchor.constraint(equalTo: resultQuantity.rightAnchor, constant: 15),

			dogPhoto.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 30),
			dogPhoto.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

			choiceResult.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			choiceResult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

			dogOptions.topAnchor.constraint(equalTo: dogPhoto.bottomAnchor, constant: 50),
			dogOptions.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

			loadingWarning.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 200),
			loadingWarning.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])
	}

	func setPhotoCounter(totalPhotos: Int) {
		photoCounter.current = 0
		photoCounter.total = totalPhotos
		resultQuantity.setText(text: "\(photoCounter.current) / \(photoCounter.total)")
	}

	private func callToLoadImages() {
		gameScreenViewModel = GameScreenViewModel()
		gameScreenViewModel.bindReadyImageToController = {
			let imageData = self.gameScreenViewModel.sendImageDataToGame()
			var options = self.gameScreenViewModel.sendRandomBreedsToGame()
			options.append(imageData.breed)
			self.loadPhotoAndOptions(imageLoaded: imageData.image, breedOptions: options, correctBreed: imageData.breed)
		}
	}

	func loadPhotoAndOptions(imageLoaded: UIImage, breedOptions: [String], correctBreed: String) {

		DispatchQueue.main.sync {
			dogPhoto.setPhoto(image: imageLoaded)
			let correctOption = dogOptions.setDogOptions(options: breedOptions, correctBreed: correctBreed)

			for index in 0...3 {

				if index == correctOption {
					dogOptions.optionsArray[index].button.addTarget(self, action: #selector(self.correctChoice), for: .touchUpInside)
				} else {
					dogOptions.optionsArray[index].button.addTarget(self, action: #selector(self.wrongChoice), for: .touchUpInside)
				}
			}

			choiceResult.setBreedAnswer(name: correctBreed)
			choiceResult.nextButton.button.addTarget(self, action: #selector(self.toResultScreen), for: .touchUpInside)

			loadingWarning.isHidden = true
			dogPhoto.isHidden = false
			dogOptions.isHidden = false
		}
	}

	@objc func correctChoice() {
		dogOptions.isHidden = true
		choiceResult.setResultLayout(correct: true)
		choiceResult.isHidden = false
	}

	@objc func wrongChoice() {
		dogOptions.isHidden = true
		choiceResult.setResultLayout(correct: false)
		choiceResult.isHidden = false
	}

	@objc func toResultScreen() {
		self.navigationController?.pushViewController(ResultScreenViewController(), animated: true)
	}

}
