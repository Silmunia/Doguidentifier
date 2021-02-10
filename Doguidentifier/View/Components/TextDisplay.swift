//
//  PhotoQuantityIndicator.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 09/02/21.
//

import UIKit

class TextDisplay: UIView {

	lazy var buttonBackground: UIImageView = {
		let background = UIImageView()
		let viewColor = UIImage.imageWithColor(color: UIColor.dogGreen)
		background.translatesAutoresizingMaskIntoConstraints = false
		background.image = viewColor
		background.layer.cornerRadius = 20
		background.clipsToBounds = true
		background.layer.borderWidth = 5
		self.addSubview(background)
		return background
	}()

	lazy var textLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 48)
		self.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = .clear

		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping

		let strokeTextAttributes: [NSAttributedString.Key: Any] = [
			.strokeColor: UIColor.black,
			.foregroundColor: UIColor.white,
			.strokeWidth: -3.0
			]

		label.attributedText = NSAttributedString(string: "8 / 15", attributes: strokeTextAttributes)
		self.addSubview(label)
		return label
	}()

	init(width: CGFloat, height: CGFloat, fontSize: CGFloat, text: String, fillColor: UIColor, borderColor: UIColor) {
		super.init(frame: .zero)

		configureLayout(width: width, height: height)

		buttonBackground.image = UIImage.imageWithColor(color: fillColor)
		buttonBackground.layer.borderColor = borderColor.cgColor

		textLabel.font = textLabel.font.withSize(fontSize)
		textLabel.text = text
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configureLayout(width: CGFloat, height: CGFloat) {
		NSLayoutConstraint.activate([
			self.heightAnchor.constraint(equalToConstant: height),
			self.widthAnchor.constraint(equalToConstant: width),

			buttonBackground.topAnchor.constraint(equalTo: self.topAnchor),
			buttonBackground.bottomAnchor.constraint(equalTo: buttonBackground.topAnchor, constant: height),
			buttonBackground.leftAnchor.constraint(equalTo: self.leftAnchor),
			buttonBackground.rightAnchor.constraint(equalTo: buttonBackground.leftAnchor, constant: width),

			textLabel.centerYAnchor.constraint(equalTo: buttonBackground.centerYAnchor),
			textLabel.topAnchor.constraint(equalTo: buttonBackground.topAnchor),
			textLabel.bottomAnchor.constraint(equalTo: buttonBackground.bottomAnchor),
			textLabel.leftAnchor.constraint(equalTo: buttonBackground.leftAnchor, constant: 10),
			textLabel.rightAnchor.constraint(equalTo: buttonBackground.rightAnchor, constant: -10)
		])
	}
}
