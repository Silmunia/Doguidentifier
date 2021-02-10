//
//  PhotoSetter.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class PhotoQuantitySetter: UIView {

	var photoQuantity = 15

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

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 36)

		label.textAlignment = .center
		label.backgroundColor = .clear

		let strokeTextAttributes: [NSAttributedString.Key: Any] = [
			.strokeColor: UIColor.black,
			.foregroundColor: UIColor.white,
			.strokeWidth: -3.0
			]

		label.attributedText = NSAttributedString(string: "Nº Fotos", attributes: strokeTextAttributes)
		self.addSubview(label)
		return label
	}()

	lazy var numberLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 48)
		self.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = .clear

		let strokeTextAttributes: [NSAttributedString.Key: Any] = [
			.strokeColor: UIColor.black,
			.foregroundColor: UIColor.white,
			.strokeWidth: -3.0
			]

		label.attributedText = NSAttributedString(string: String(photoQuantity), attributes: strokeTextAttributes)
		self.addSubview(label)
		return label
	}()

	lazy var downSetImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.image = UIImage(named: "DownButton")
		self.addSubview(view)
		return view
	}()

	lazy var downSetButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(self.reduceQuantity), for: .touchUpInside)
		self.addSubview(button)
		return button
	}()

	lazy var upSetImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.image = UIImage(named: "UpButton")
		self.addSubview(view)
		return view
	}()

	lazy var upSetButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(self.increaseCount), for: .touchUpInside)
		self.addSubview(button)
		return button
	}()

	init(width: CGFloat, height: CGFloat, fillColor: UIColor, borderColor: UIColor) {
		super.init(frame: .zero)

		configureLayout(width: width, height: height)

		buttonBackground.image = UIImage.imageWithColor(color: fillColor)
		buttonBackground.layer.borderColor = borderColor.cgColor
	}

	func configureLayout(width: CGFloat, height: CGFloat) {
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: width),
			self.bottomAnchor.constraint(equalTo: self.topAnchor, constant: height),

			buttonBackground.topAnchor.constraint(equalTo: self.topAnchor),
			buttonBackground.bottomAnchor.constraint(equalTo: buttonBackground.topAnchor, constant: height),
			buttonBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			buttonBackground.widthAnchor.constraint(equalToConstant: width),

			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			titleLabel.centerXAnchor.constraint(equalTo: buttonBackground.centerXAnchor),
			titleLabel.leftAnchor.constraint(equalTo: buttonBackground.leftAnchor),
			titleLabel.rightAnchor.constraint(equalTo: buttonBackground.rightAnchor),

			numberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
			numberLabel.centerXAnchor.constraint(equalTo: buttonBackground.centerXAnchor),
			numberLabel.leftAnchor.constraint(equalTo: buttonBackground.leftAnchor),
			numberLabel.rightAnchor.constraint(equalTo: buttonBackground.rightAnchor),

			downSetImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			downSetImage.leftAnchor.constraint(equalTo: buttonBackground.leftAnchor, constant: 20),
			downSetImage.heightAnchor.constraint(equalToConstant: 50),
			downSetImage.widthAnchor.constraint(equalToConstant: 50),

			upSetImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			upSetImage.rightAnchor.constraint(equalTo: buttonBackground.rightAnchor, constant: -20),
			upSetImage.heightAnchor.constraint(equalToConstant: 50),
			upSetImage.widthAnchor.constraint(equalToConstant: 50),

			downSetButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			downSetButton.leftAnchor.constraint(equalTo: buttonBackground.leftAnchor, constant: 20),
			downSetButton.heightAnchor.constraint(equalToConstant: 50),
			downSetButton.widthAnchor.constraint(equalToConstant: 50),

			upSetButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			upSetButton.rightAnchor.constraint(equalTo: buttonBackground.rightAnchor, constant: -20),
			upSetButton.heightAnchor.constraint(equalToConstant: 50),
			upSetButton.widthAnchor.constraint(equalToConstant: 50)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func increaseCount() {
		if photoQuantity < 25 {
			photoQuantity += 5
			numberLabel.text = String(photoQuantity)
		}
	}

	@objc func reduceQuantity() {
		if photoQuantity > 5 {
			photoQuantity -= 5
			numberLabel.text = String(photoQuantity)
		}
	}

}
