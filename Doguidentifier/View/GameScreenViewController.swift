//
//  GameScreenViewController.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class GameScreenViewController: UIViewController {
	
	lazy var screenBackground : UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleAspectFit
		let img = UIImage(named: "GameScreenPattern")
		imgView.image = img
		return imgView
	}()
	
	lazy var resultQuantity : PhotoQuantityIndicator = {
		let indicator = PhotoQuantityIndicator(width: 150, height: 60, fontSize: 32, text: "25 / 25", fillColor: UIColor.dogNavy, borderColor: UIColor.dogPaleNavy)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()
	
	lazy var exitButton : DogButton = {
		let button = DogButton(width: 150, height: 60, text: "Sair", fontSize: 32, fillColor: UIColor.dogRed, borderColor: UIColor.dogWhite)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	lazy var dogPhoto : DogPhoto = {
		let photo = DogPhoto(photo: "TestDog1")
		photo.translatesAutoresizingMaskIntoConstraints = false
		return photo
	}()
	
	lazy var dogOptions : DogOptions = {
		let options = DogOptions(options: ["Staffordshire Bullterrier", "German Longhaired Pointer", "Shetland Sheepdog", "Dalmatian"])
		options.translatesAutoresizingMaskIntoConstraints = false
		return options
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationController?.navigationBar.barStyle = .black

		configureLayout()
		dogOptions.firstOption.button.addTarget(self, action: #selector(self.toResultScreen), for: .touchUpInside)
		super.view.backgroundColor = UIColor.dogPurple
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
			
			dogOptions.topAnchor.constraint(equalTo: dogPhoto.bottomAnchor, constant: 50),
			dogOptions.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
		])
	}
	
	@objc func toResultScreen() {
		self.navigationController?.pushViewController(ResultScreenViewController(), animated: true)
	}

}
