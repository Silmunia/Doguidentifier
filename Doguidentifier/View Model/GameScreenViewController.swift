//
//  GameScreenViewController.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

class GameScreenViewController: UIViewController {

	lazy var buttonBackground: UIImageView = {
		let background = UIImageView()
		let viewColor = UIImage.imageWithColor(color: .green)
		background.translatesAutoresizingMaskIntoConstraints = false
		background.image = viewColor
		self.view.addSubview(background)
		return background
	}()
	
	lazy var button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .none
		button.addTarget(self, action: #selector(self.toResultScreen), for: .touchUpInside)
		self.view.addSubview(button)
		return button
	}()
	
	lazy var buttonLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		let systemFont = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.black)
		label.font = UIFont(descriptor: systemFont.fontDescriptor.withDesign(.rounded)!, size: 48)
		self.view.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = .clear
		
		let strokeTextAttributes: [NSAttributedString.Key : Any] = [
			.strokeColor : UIColor.black,
			.foregroundColor : UIColor.white,
			.strokeWidth : -3.0,
			]

		label.attributedText = NSAttributedString(string: "Jogar", attributes: strokeTextAttributes)
		
		return label
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configureLayout()
		
		super.view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    
	@objc func toResultScreen() {
		self.navigationController?.pushViewController(ResultScreenViewController(), animated: true)
	}
	
	private func configureLayout() {
		NSLayoutConstraint.activate([
			buttonBackground.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
			buttonBackground.bottomAnchor.constraint(equalTo: buttonBackground.topAnchor, constant: 100),
			buttonBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100),
			buttonBackground.widthAnchor.constraint(equalToConstant: 200),
			
			button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
			button.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 100),
			button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100),
			button.widthAnchor.constraint(equalToConstant: 200),
			
			buttonLabel.centerYAnchor.constraint(equalTo: buttonBackground.centerYAnchor),
			buttonLabel.leftAnchor.constraint(equalTo: self.buttonBackground.leftAnchor),
			buttonLabel.rightAnchor.constraint(equalTo: self.buttonBackground.rightAnchor)
			
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
