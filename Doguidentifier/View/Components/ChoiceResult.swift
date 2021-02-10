//
//  ChoiceResult.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 10/02/21.
//

import UIKit

class ChoiceResult: UIView {
	
	lazy var resultTitle : TextDisplay = {
		let title = TextDisplay(width: 255, height: 65, fontSize: 42, text: "Resultado", fillColor: UIColor.dogNavy, borderColor: UIColor.dogPaleNavy)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	lazy var leftDogImage : UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.image = UIImage(named: "TestDog1")
		return view
	}()
	
	lazy var rightDogImage : UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.image = UIImage(named: "TestDog2")
		return view
	}()
	
	lazy var photoAnswer : TextDisplay = {
		let answer = TextDisplay(width: 280, height: 140, fontSize: 30, text: "Catioro", fillColor: UIColor.dogPurple, borderColor: UIColor.dogPalePurple)
		answer.translatesAutoresizingMaskIntoConstraints = false
		return answer
	}()
	
	lazy var nextButton : DogButton = {
		let button = DogButton(width: 190, height: 60, text: "Próxima", fontSize: 36, fillColor: UIColor.dogYellow, borderColor: UIColor.dogWhite)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	init() {
		super.init(frame: .zero)
		
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureLayout() {
		self.addSubview(nextButton)
		self.addSubview(photoAnswer)
		self.addSubview(rightDogImage)
		self.addSubview(leftDogImage)
		self.addSubview(resultTitle)
		
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 450),
			self.heightAnchor.constraint(equalToConstant: 370),
			
			nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			nextButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: -60),
			nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			
			photoAnswer.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
			photoAnswer.topAnchor.constraint(equalTo: photoAnswer.bottomAnchor, constant: -140),
			photoAnswer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			photoAnswer.widthAnchor.constraint(equalToConstant: 280),
			
			resultTitle.bottomAnchor.constraint(equalTo: photoAnswer.topAnchor, constant: -30),
			resultTitle.topAnchor.constraint(equalTo: resultTitle.bottomAnchor, constant: -65),
			resultTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			resultTitle.widthAnchor.constraint(equalToConstant: 255),
		])
	}
	
	public func setResultLayout(is result: Bool, species: String) {
		if result {
			resultTitle.textLabel.text = "Correto!"
			photoAnswer.textLabel.text = species
			
			photoAnswer.buttonBackground.image = UIImage.imageWithColor(color: UIColor.dogGreen)
			photoAnswer.buttonBackground.layer.borderColor = UIColor.dogPaleGreen.cgColor
			
			leftDogImage.image = UIImage(named: "YellowDogHappy")
			rightDogImage.image = UIImage(named: "WhiteDogHappy")
		} else {
			resultTitle.textLabel.text = "Errado!"
			photoAnswer.textLabel.text = species
			
			photoAnswer.buttonBackground.image = UIImage.imageWithColor(color: UIColor.dogRed)
			photoAnswer.buttonBackground.layer.borderColor = UIColor.dogPaleRed.cgColor
			
			leftDogImage.image = UIImage(named: "WhiteDogShock")
			rightDogImage.image = UIImage(named: "YellowDogShock")
		}
		
		var rightDogSize : CGFloat = 115
		var rightDogMargin : CGFloat = -50
		var leftDogSize : CGFloat = 100
		var leftDogMargin : CGFloat = 40
		var leftDogY : CGFloat = -10
		
		if !result {
			rightDogSize = 100
			rightDogMargin = -35
			leftDogSize = 150
			leftDogMargin = 50
			leftDogY = -15
		}
		
		NSLayoutConstraint.activate([
			rightDogImage.leftAnchor.constraint(equalTo: resultTitle.rightAnchor, constant: rightDogMargin),
			rightDogImage.rightAnchor.constraint(equalTo: rightDogImage.leftAnchor, constant: rightDogSize),
			rightDogImage.heightAnchor.constraint(equalToConstant: rightDogSize),
			rightDogImage.centerYAnchor.constraint(equalTo: resultTitle.centerYAnchor, constant: -5),
			
			leftDogImage.rightAnchor.constraint(equalTo: resultTitle.leftAnchor, constant: leftDogMargin),
			leftDogImage.leftAnchor.constraint(equalTo: leftDogImage.rightAnchor, constant: -1*leftDogSize),
			leftDogImage.heightAnchor.constraint(equalToConstant: leftDogSize),
			leftDogImage.centerYAnchor.constraint(equalTo: resultTitle.centerYAnchor, constant: leftDogY),
		])
	}

}
