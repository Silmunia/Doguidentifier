//
//  BoneTitle.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 09/02/21.
//

import UIKit

class BoneTitle: UIView {

	lazy var boneImage : UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		view.image = UIImage(named: "ResultBone")
		return view
	}()
	
	lazy var boneLabel : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 48)
		label.textAlignment = .center
		label.backgroundColor = .clear
		
		let strokeTextAttributes: [NSAttributedString.Key : Any] = [
			.strokeColor : UIColor.dogNavy,
			.foregroundColor : UIColor.dogWhite,
			.strokeWidth : -3.0,
			]

		label.attributedText = NSAttributedString(string: "Resultado", attributes: strokeTextAttributes)
		return label
	}()
	
	init() {
		super.init(frame: .zero)
		
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureLayout() {
		self.addSubview(boneImage)
		self.addSubview(boneLabel)
		
		NSLayoutConstraint.activate([
			self.widthAnchor.constraint(equalToConstant: 370),
			self.heightAnchor.constraint(equalToConstant: 180),
			
			boneImage.topAnchor.constraint(equalTo: self.topAnchor),
			boneImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			boneImage.widthAnchor.constraint(equalToConstant: 370),
			boneImage.heightAnchor.constraint(equalToConstant: 180),
			
			boneLabel.leftAnchor.constraint(equalTo: boneImage.leftAnchor),
			boneLabel.rightAnchor.constraint(equalTo: boneImage.rightAnchor),
			boneLabel.centerXAnchor.constraint(equalTo: boneImage.centerXAnchor),
			boneLabel.centerYAnchor.constraint(equalTo: boneImage.centerYAnchor),
		])
	}

}
