//
//  MiscWeatherBubbles.swift
//  Weather App
//
//  Created by Daniel Efrain Ocasio on 8/29/23.
//

import Foundation
import UIKit

class MiscWeatherView: UIView {
	
	lazy var colorManager = ViewDesignManager()
	
	lazy var boxIcon: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		image.image = UIImage(systemName: "thermometer.sun")
		return image
	}()
	
	lazy var boxTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 10)
		label.text = "High & Low"
		return label
	}()
	
	lazy var boxDetailOne: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 10)
		return label
	}()
	
	lazy var boxDetailTwo: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 10)
		return label
	}()
	
	
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		generalUISetup()
		setupAttributes()
		
	}
	
	//MARK: - General UI setup
	func generalUISetup() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = colorManager.bubbleColor
		layer.cornerRadius = 20
		widthAnchor.constraint(equalToConstant: 123).isActive = true
		heightAnchor.constraint(equalToConstant: 58).isActive = true
	}
	
	
	//MARK: - Box Attributes
	func setupAttributes() {
		//Box Icon
		addSubview(boxIcon)
		boxIcon.tintColor = colorManager.sixtyWhite
		//Box Title
		addSubview(boxTitle)
		boxTitle.textColor = colorManager.sixtyWhite
		//Box Detail One
		addSubview(boxDetailOne)
		boxDetailOne.textColor = colorManager.ninetyWhite
		//Box Detail Two
		addSubview(boxDetailTwo)
		boxDetailTwo.textColor = colorManager.ninetyWhite

		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
