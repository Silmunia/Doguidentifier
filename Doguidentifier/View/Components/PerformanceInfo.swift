//
//  PerformanceInfo.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 09/02/21.
//

import UIKit

class PerformanceInfo: UIView {

	lazy var background: UIImageView = {
		let background = UIImageView()
		let viewColor = UIImage.imageWithColor(color: UIColor.dogPurple)
		background.translatesAutoresizingMaskIntoConstraints = false
		background.image = viewColor
		background.layer.cornerRadius = 20
		background.clipsToBounds = true
		background.layer.borderWidth = 5
		background.layer.borderColor = UIColor.dogPalePurple.cgColor
		self.addSubview(background)
		return background
	}()

	lazy var symbolImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.image = UIImage(named: "Paw")
		self.addSubview(view)
		return view
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 28)
		self.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = .clear

		let strokeTextAttributes: [NSAttributedString.Key: Any] = [
			.strokeColor: UIColor.dogNavy,
			.foregroundColor: UIColor.dogWhite,
			.strokeWidth: -3.0
			]

		label.attributedText = NSAttributedString(string: "Mais Acertos", attributes: strokeTextAttributes)
		self.addSubview(label)
		return label
	}()

	lazy var descLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 20)
		self.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = .clear

		let strokeTextAttributes: [NSAttributedString.Key: Any] = [
			.strokeColor: UIColor.dogNavy,
			.foregroundColor: UIColor.dogWhite,
			.strokeWidth: -3.0
			]

		label.attributedText = NSAttributedString(string: "German Longhaired Pointer", attributes: strokeTextAttributes)
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		self.addSubview(label)
		return label
	}()

	init (imageName: String, title: String, dogSpecies: String) {
		super.init(frame: .zero)

		configureLayout()

		symbolImage.image = UIImage(named: imageName)
		titleLabel.text = title
		descLabel.text = dogSpecies
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configureLayout() {
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 370),
			self.heightAnchor.constraint(equalToConstant: 120),

			background.topAnchor.constraint(equalTo: self.topAnchor),
			background.bottomAnchor.constraint(equalTo: background.topAnchor, constant: 150),
			background.leftAnchor.constraint(equalTo: self.leftAnchor),
			background.rightAnchor.constraint(equalTo: background.leftAnchor, constant: 370),

			symbolImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 20),
			symbolImage.bottomAnchor.constraint(equalTo: symbolImage.topAnchor, constant: 110),
			symbolImage.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 20),
			symbolImage.rightAnchor.constraint(equalTo: symbolImage.leftAnchor, constant: 110),

			titleLabel.topAnchor.constraint(equalTo: symbolImage.topAnchor),
			titleLabel.leftAnchor.constraint(equalTo: symbolImage.rightAnchor, constant: 5),
			titleLabel.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -15),
			titleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),

			descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
			descLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
			descLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
			descLabel.bottomAnchor.constraint(equalTo: symbolImage.bottomAnchor)
		])
	}

}
