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
	
	lazy var startButton : DogButton = {
		let button = DogButton(width: 250, height: 90, text: "Jogar", fontSize: 48, fillColor: UIColor.dogGreen, borderColor: UIColor.dogWhite)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	lazy var quitButton : DogButton = {
		let button = DogButton(width: 250, height: 90, text: "Encerrar", fontSize: 48, fillColor: UIColor.dogRed, borderColor: UIColor.dogWhite)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.dogYellow
		
		
		configureLayout()
    }
    
	@objc func toGameScreen() {
		self.navigationController?.pushViewController(GameScreenViewController(), animated: true)
	}
	
	private func configureLayout() {
		self.view.addSubview(screenBackground)
		self.view.addSubview(titleImage)
		self.view.addSubview(startButton)
		self.view.addSubview(quitButton)
		
		NSLayoutConstraint.activate([
			screenBackground.topAnchor.constraint(equalTo: self.view.topAnchor),
			screenBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			screenBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			screenBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			
			titleImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
			titleImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			titleImage.widthAnchor.constraint(equalToConstant: 370),
			titleImage.heightAnchor.constraint(equalToConstant: 280),
			
			startButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 650),
			startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			
			quitButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10),
			quitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
		])
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
