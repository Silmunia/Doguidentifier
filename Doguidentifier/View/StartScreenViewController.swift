//
//  StartScreenViewController.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class StartScreenViewController: UIViewController {

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
		button.button.addTarget(self, action: #selector(self.toGameScreen), for: .touchUpInside)
		return button
	}()

	lazy var numPhotoSetter: PhotoQuantitySetter = {
		let setter = PhotoQuantitySetter(
			width: 250,
			height: 150,
			fillColor: UIColor.dogPurple,
			borderColor: UIColor.dogPalePurple
		)
		setter.translatesAutoresizingMaskIntoConstraints = false
		return setter
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.dogYellow

		configureLayout()
    }

	private func configureLayout() {
		self.view.addSubview(screenBackground)
		self.view.addSubview(titleImage)
		self.view.addSubview(numPhotoSetter)
		self.view.addSubview(startButton)

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
			startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
		])
	}

	@objc func toGameScreen() {
		self.navigationController?.pushViewController(GameScreenViewController(), animated: true)
	}

}
