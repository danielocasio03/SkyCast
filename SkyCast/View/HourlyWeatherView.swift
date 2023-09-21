//
//  hourlyWeatherView.swift
//  Sky Cast
//
//  Created by Daniel Efrain Ocasio on 8/28/23.
//

import Foundation
import UIKit

class HourlyWeatherView: UIView {
	let colorManager = ViewDesignManager()
	
	lazy var timeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 10)
		label.text = "Now"
		return label
	}()
	
	lazy var weatherIcon: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
//		image.image = UIImage(named: "thunder-rain" )
		return image
	}()
	
	lazy var temperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 14)
		label.text = "74°"
		return label
	}()
	
	lazy var rainlabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 8)
		label.text = "100%"
		label.textColor = .gray
		return label
	}()
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	func setupView() {
		//Background
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = colorManager.bubbleColor
		layer.cornerRadius = 20
		layer.borderColor = colorManager.fadedBlack.cgColor
		layer.borderWidth = 0.25
		//Time Label
		addSubview(timeLabel)
		timeLabel.textColor = colorManager.ninetyWhite
		//Weather Icon
		addSubview(weatherIcon)
		weatherIcon.tintColor = colorManager.ninetyWhite
		//Temperature Label
		addSubview(temperatureLabel)
		temperatureLabel.textColor = colorManager.ninetyWhite
		//Rain Label
		addSubview(rainlabel)
		
		NSLayoutConstraint.activate([
			//Time Icon
			timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
			timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			//Weather Icon
			weatherIcon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
			weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
			//Temperature Label
			temperatureLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40),
			temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 2),
			//Rain Label
			rainlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			rainlabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5)
		])
	}
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
