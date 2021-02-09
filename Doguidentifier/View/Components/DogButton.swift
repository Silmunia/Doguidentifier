//
//  DogButton.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class DogButton: UIView {

	lazy var buttonBackground : UIImageView = {
		let background = UIImageView()
		let viewColor = UIImage.imageWithColor(color: UIColor.dogGreen)
		background.translatesAutoresizingMaskIntoConstraints = false
		background.image = viewColor
		background.layer.cornerRadius = 20
		background.clipsToBounds = true
		background.layer.borderWidth = 5
		background.layer.borderColor = UIColor.dogWhite.cgColor
		self.addSubview(background)
		return background
	}()
	
	lazy var button : UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isUserInteractionEnabled = true
		self.addSubview(button)
		return button
	}()
	
	lazy var buttonLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 48)
		self.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = .clear
		
		let strokeTextAttributes: [NSAttributedString.Key : Any] = [
			.strokeColor : UIColor.dogNavy,
			.foregroundColor : UIColor.dogWhite,
			.strokeWidth : -3.0,
			]

		label.attributedText = NSAttributedString(string: "Jogar", attributes: strokeTextAttributes)
		
		return label
	}()
	
	init(width: CGFloat, height: CGFloat, text: String, fontSize: CGFloat, fillColor: UIColor, borderColor: UIColor) {
		super.init(frame: .zero)
		
		configureLayout(width: width, height: height)
		
		buttonBackground.image = UIImage.imageWithColor(color: fillColor)
		buttonBackground.layer.borderColor = borderColor.cgColor
		
		buttonLabel.font = buttonLabel.font.withSize(fontSize)
		buttonLabel.text = text
	}
	
	func configureLayout(width: CGFloat, height: CGFloat) {
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: width),
			self.bottomAnchor.constraint(equalTo: self.topAnchor, constant: height),
			
			buttonBackground.topAnchor.constraint(equalTo: self.topAnchor),
			buttonBackground.bottomAnchor.constraint(equalTo: buttonBackground.topAnchor, constant: height),
			buttonBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			buttonBackground.widthAnchor.constraint(equalToConstant: width),
			
			buttonLabel.centerYAnchor.constraint(equalTo: buttonBackground.centerYAnchor),
			buttonLabel.leftAnchor.constraint(equalTo: buttonBackground.leftAnchor),
			buttonLabel.rightAnchor.constraint(equalTo: buttonBackground.rightAnchor),
			
			button.topAnchor.constraint(equalTo: buttonBackground.topAnchor),
			button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			button.centerXAnchor.constraint(equalTo: buttonBackground.centerXAnchor),
			button.centerYAnchor.constraint(equalTo: buttonBackground.centerYAnchor),
			button.widthAnchor.constraint(equalToConstant: width),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
