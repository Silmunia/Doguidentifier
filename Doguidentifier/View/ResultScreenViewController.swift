//
//  ResultScreenViewController.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class ResultScreenViewController: UIViewController {
	
	lazy var screenBackground : UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		imgView.contentMode = .scaleAspectFit
		let img = UIImage(named: "StartEndScreenPattern")
		imgView.image = img
		return imgView
	}()
	
	lazy var boneTitle : BoneTitle = {
		let title = BoneTitle()
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	lazy var resultQuantity : PhotoQuantityIndicator = {
		let indicator = PhotoQuantityIndicator(width: 210, height: 120, fontSize: 54, text: "25 / 25", fillColor: UIColor.dogPurple, borderColor: UIColor.dogPalePurple)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()
	
	lazy var bestPerformance : PerformanceInfo = {
		let performance = PerformanceInfo(imageName: "Paw", title: "Mais Acertos", dogSpecies: "German Longhaired Pointer")
		performance.translatesAutoresizingMaskIntoConstraints = false
		return performance
	}()
	
	lazy var worstPerformance : PerformanceInfo = {
		let performance = PerformanceInfo(imageName: "Question", title: "Menos Acertos", dogSpecies: "German Longhaired Pointer")
		performance.translatesAutoresizingMaskIntoConstraints = false
		return performance
	}()
	
	lazy var repeatButton : DogButton = {
		let button = DogButton(width: 180, height: 70, text: "Repetir", fontSize: 42, fillColor: UIColor.dogGreen, borderColor: UIColor.dogWhite)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.button.addTarget(self, action: #selector(self.toGameScreen), for: .touchUpInside)
		return button
	}()
	
	lazy var backButton : DogButton = {
		let button = DogButton(width: 180, height: 70, text: "Sair", fontSize: 42, fillColor: UIColor.dogRed, borderColor: UIColor.dogWhite)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.button.addTarget(self, action: #selector(self.toStartScreen), for: .touchUpInside)
		return button
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.dogYellow
		
		configureLayout()
	}
	
	@objc func toStartScreen() {
		self.navigationController?.pushViewController(StartScreenViewController(), animated: true)
	}
	
	@objc func toGameScreen() {
		self.navigationController?.pushViewController(GameScreenViewController(), animated: true)
	}
	
	private func configureLayout() {
		self.view.addSubview(screenBackground)
		self.view.addSubview(boneTitle)
		self.view.addSubview(resultQuantity)
		self.view.addSubview(bestPerformance)
		self.view.addSubview(worstPerformance)
		self.view.addSubview(repeatButton)
		self.view.addSubview(backButton)
		
		NSLayoutConstraint.activate([
			screenBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
			screenBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			screenBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			screenBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			
			boneTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
			boneTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
			resultQuantity.topAnchor.constraint(equalTo: boneTitle.bottomAnchor, constant: 15),
			resultQuantity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
			bestPerformance.topAnchor.constraint(equalTo: resultQuantity.bottomAnchor, constant: 10),
			bestPerformance.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
			worstPerformance.topAnchor.constraint(equalTo: bestPerformance.bottomAnchor, constant: 45),
			worstPerformance.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
			repeatButton.topAnchor.constraint(equalTo: worstPerformance.bottomAnchor, constant: 70),
			repeatButton.leftAnchor.constraint(equalTo: worstPerformance.leftAnchor),
			backButton.topAnchor.constraint(equalTo: worstPerformance.bottomAnchor, constant: 70),
			backButton.rightAnchor.constraint(equalTo: worstPerformance.rightAnchor),
		])
	}

}
