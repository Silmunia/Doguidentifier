//
//  DogOptions.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 09/02/21.
//

import UIKit

class DogOptions: UIView {

	var optionsWidth: CGFloat = 175
	var optionsHeight: CGFloat = 120
	var optionsFont: CGFloat = 20

	lazy var firstOption: DogButton = {
		let button = DogButton(
			width: optionsWidth,
			height: optionsHeight,
			text: "Option 1",
			fontSize: optionsFont,
			fillColor: UIColor.dogBlue,
			borderColor: UIColor.dogWhite
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(button)
		return button
	}()

	lazy var secondOption: DogButton = {
		let button = DogButton(
			width: optionsWidth,
			height: optionsHeight,
			text: "Option 2",
			fontSize: optionsFont,
			fillColor: UIColor.dogBlue,
			borderColor: UIColor.dogWhite
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(button)
		return button
	}()

	lazy var thirdOption: DogButton = {
		let button = DogButton(
			width: optionsWidth,
			height: optionsHeight,
			text: "Option 3",
			fontSize: optionsFont,
			fillColor: UIColor.dogBlue,
			borderColor: UIColor.dogWhite
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(button)
		return button
	}()

	lazy var fourthOption: DogButton = {
		let button = DogButton(
			width: optionsWidth,
			height: optionsHeight,
			text: "Option 4",
			fontSize: optionsFont,
			fillColor: UIColor.dogBlue,
			borderColor: UIColor.dogWhite
		)
		button.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(button)
		return button
	}()

	var optionsArray: [DogButton] = []

	init (options: [String]) {
		super.init(frame: .zero)

		configureLayout()

		optionsArray = [firstOption, secondOption, thirdOption, fourthOption]

		for index in 0..<4 {
			optionsArray[index].buttonLabel.text = options[index]
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setDogOptions(options: [String], correctBreed: String) -> Int {

		var availableOptions = options
		availableOptions.shuffle()

		var correctIndex = 5

		for index in 0..<4 {
			optionsArray[index].buttonLabel.text = availableOptions[index]

			if availableOptions[index] == correctBreed {
				correctIndex = index
			}
		}

		return correctIndex
	}

	private func configureLayout() {
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 370),
			self.heightAnchor.constraint(equalToConstant: 370),

			firstOption.topAnchor.constraint(equalTo: self.topAnchor),
			firstOption.leftAnchor.constraint(equalTo: self.leftAnchor),

			secondOption.topAnchor.constraint(equalTo: self.topAnchor),
			secondOption.rightAnchor.constraint(equalTo: self.rightAnchor),

			thirdOption.topAnchor.constraint(equalTo: firstOption.bottomAnchor, constant: 30),
			thirdOption.leftAnchor.constraint(equalTo: self.leftAnchor),

			fourthOption.topAnchor.constraint(equalTo: secondOption.bottomAnchor, constant: 30),
			fourthOption.rightAnchor.constraint(equalTo: self.rightAnchor)
		])
	}

}
