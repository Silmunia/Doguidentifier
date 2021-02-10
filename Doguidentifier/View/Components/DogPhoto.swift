//
//  DogPhoto.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 09/02/21.
//

import UIKit

class DogPhoto: UIView {

	lazy var photoBackground : UIImageView = {
		let background = UIImageView()
		let viewColor = UIImage.imageWithColor(color: UIColor.dogGreen)
		background.translatesAutoresizingMaskIntoConstraints = false
		background.image = viewColor
		background.layer.cornerRadius = 20
		background.clipsToBounds = true
		background.layer.borderWidth = 5
		background.layer.borderColor = UIColor.dogPaleGreen.cgColor
		self.addSubview(background)
		return background
	}()
	
	lazy var photoView : UIImageView = {
		let photo = UIImageView()
		photo.translatesAutoresizingMaskIntoConstraints = false
		photo.layer.cornerRadius = 10
		photo.clipsToBounds = true
		photo.contentMode = .scaleAspectFit
		self.addSubview(photo)
		return photo
	}()
	
	init (photo: String) {
		super.init(frame: .zero)
		
		configureLayout()
		
		photoView.image = UIImage(named: photo)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureLayout() {
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 315),
			self.heightAnchor.constraint(equalToConstant: 315),
			
			photoBackground.topAnchor.constraint(equalTo: self.topAnchor),
			photoBackground.leftAnchor.constraint(equalTo: self.leftAnchor),
			photoBackground.rightAnchor.constraint(equalTo: photoBackground.leftAnchor, constant: 315),
			photoBackground.bottomAnchor.constraint(equalTo: photoBackground.topAnchor, constant: 315),
			
			photoView.topAnchor.constraint(equalTo: photoBackground.topAnchor, constant: 10),
			photoView.leftAnchor.constraint(equalTo: photoBackground.leftAnchor, constant: 10),
			photoView.rightAnchor.constraint(equalTo: photoBackground.rightAnchor, constant: -10),
			photoView.bottomAnchor.constraint(equalTo: photoBackground.bottomAnchor, constant: -10),
			
		])
	}

}
