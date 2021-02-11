//
//  StartScreenViewController.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class StartScreenViewController: UIViewController {

	private var startScreenViewModel: StartScreenViewModel!

	lazy var titleImage: UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleAspectFit
		let img = UIImage(named: "TitleImage")
		imgView.image = img
		return imgView
	}()

	lazy var screenBackground: UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleAspectFit
		let img = UIImage(named: "StartEndScreenPattern")
		imgView.image = img
		return imgView
	}()

	lazy var prepareButton: DogButton = {
		let button = DogButton(
			width: 250,
			height: 90,
			text: "Preparar",
			fontSize: 48,
			fillColor: UIColor.dogNavy,
			borderColor: UIColor.dogPaleNavy
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.button.addTarget(self, action: #selector(self.prepareStartGame), for: .touchUpInside)
		return button
	}()

	lazy var startButton: DogButton = {
		let button = DogButton(
			width: 250,
			height: 90,
			text: "Jogar",
			fontSize: 48,
			fillColor: UIColor.dogGreen,
			borderColor: UIColor.dogWhite
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.button.addTarget(self, action: #selector(self.startGame), for: .touchUpInside)
		return button
	}()

	lazy var numPhotoSetter: PhotoQuantitySetter = {
		let setter = PhotoQuantitySetter(
			width: 250,
			height: 150,
			fillColor: UIColor.dogPurple,
			borderColor: UIColor.dogPalePurple
		)
		setter.upSetButton.addTarget(self, action: #selector(self.increaseQuantity), for: .touchUpInside)
		setter.downSetButton.addTarget(self, action: #selector(self.reduceQuantity), for: .touchUpInside)
		setter.translatesAutoresizingMaskIntoConstraints = false
		return setter
	}()
	
	lazy var loadingWarning: TextDisplay = {
		let text = TextDisplay(
			width: 300,
			height: 90,
			fontSize: 42,
			text: "Carregando...",
			fillColor: UIColor.dogPurple,
			borderColor: UIColor.dogPalePurple
		)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.dogYellow

		configureLayout()

		startButton.isHidden = true
		loadingWarning.isHidden = true

		callToGetBreedList()
    }

	private func configureLayout() {
		self.view.addSubview(screenBackground)
		self.view.addSubview(titleImage)
		self.view.addSubview(numPhotoSetter)
		self.view.addSubview(startButton)
		self.view.addSubview(prepareButton)
		self.view.addSubview(loadingWarning)

		NSLayoutConstraint.activate([
			screenBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
			screenBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			screenBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			screenBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor),

			titleImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
			titleImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			titleImage.widthAnchor.constraint(equalToConstant: 370),
			titleImage.heightAnchor.constraint(equalToConstant: 280),

			numPhotoSetter.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 75),
			numPhotoSetter.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

			startButton.topAnchor.constraint(equalTo: numPhotoSetter.bottomAnchor, constant: 40),
			startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

			prepareButton.topAnchor.constraint(equalTo: numPhotoSetter.bottomAnchor, constant: 40),
			prepareButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
			loadingWarning.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 75),
			loadingWarning.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])
	}

	private func callToGetBreedList() {

		self.startScreenViewModel = StartScreenViewModel()
		self.startScreenViewModel.breedListToController = {}
	}

	@objc func increaseQuantity() {
		var quantity = numPhotoSetter.getQuantity()

		if quantity < 25 {
			numPhotoSetter.increaseQuantity()
			quantity = numPhotoSetter.getQuantity()

			if quantity == 25 {
				numPhotoSetter.hideUpButton()
			} else if quantity == 10 {
				numPhotoSetter.showDownButton()
			}
		}
	}

	@objc func reduceQuantity() {
		var quantity = numPhotoSetter.getQuantity()

		if quantity > 5 {
			numPhotoSetter.reduceQuantity()
			quantity = numPhotoSetter.getQuantity()

			if quantity == 5 {
				numPhotoSetter.hideDownButton()
			} else if quantity == 20 {
				numPhotoSetter.showUpButton()
			}
		}
	}

	@objc func prepareStartGame() {

		startScreenViewModel.getBreedImages(quantity: numPhotoSetter.getQuantity())
		prepareButton.isHidden = true
		numPhotoSetter.isHidden = true
		loadingWarning.isHidden = false

		startScreenViewModel.imageListToController = {
			self.gameReady()
		}
	}

	private func gameReady() {
		startButton.isHidden = false
		loadingWarning.isHidden = true
	}

	@objc func startGame() {
		self.navigationController?.pushViewController(GameScreenViewController(), animated: true)
	}

}
