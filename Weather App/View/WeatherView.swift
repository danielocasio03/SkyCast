//
//  WeatherView.swift
//  Weather App
//
//  Created by Daniel Efrain Ocasio on 8/21/23.
//

import Foundation
import UIKit

class WeatherView: UIView {
	let viewDesignManager = ViewDesignManager()
	
	
//MARK: - General UI Declaration
	let backgroundImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		return image
	}()
	
	let searchButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
		button.tintColor = .white
		return button
		
	}()
	
	let searchField: UITextField = {
		let textField = UITextField()
		let padding = UIView()
		padding.frame = CGRect(x: 0, y: 0, width: 12, height: 0)
		textField.leftView = (padding)
		textField.leftViewMode = .always
		
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Enter a City..."
		return textField
	}()
	
	let cityTempLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.font = UIFont(name: "Roboto-Light", size: 48)
		label.textAlignment = .center
		label.numberOfLines = 2
		return label
	}()
	
	let weatherCondition: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Roboto-Light", size: 20)
		label.textAlignment = .center
		label.textColor = .white
//		label.text = "Rainy"
		return label
	}()
	
	let greetingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Roboto-Light", size: 18)
		label.textAlignment = .center
		label.textColor = .white.withAlphaComponent(0.7)
		return label
	}()
	
	let locationButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		let image = UIImage(systemName: "location.circle.fill")?.withRenderingMode(.alwaysTemplate)
		button.setImage(image, for: .normal)
		button.tintColor = .white
		button.contentMode = .scaleAspectFit
//		button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 00, bottom: 0, right: 0)
		return button
	}()
	
	
//MARK: - StackView Declaration
	let hourlyWeatherView = HourlyWeatherView()
	
	let hourlyWeatherStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .equalSpacing
		stack.axis = .horizontal
		stack.alignment = .leading
		return stack
	}()
	
	
//MARK: - Declaration of Weather Bubbles
	//First Weather Bubble
	let highLowBubble = MiscWeatherView()
	
	let highLowHLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 10)
		label.text = "H:"
		return label
	}()
	let highLowLLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Arial", size: 10)
		label.text = "L:"
		return label
	}()
	
	//Second Weather Bubble
	let riseAndSetBubble = MiscWeatherView()
	
	let sunriseImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		image.image = UIImage(systemName: "sunrise")
		return image
	}()
	
	let sunsetImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		image.image = UIImage(systemName: "sunset")
		return image
	}()
	
	//Third Weather Bubble
	let windSpeedBubble = MiscWeatherView()
	
	
//MARK: - Start of executed code
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		UISetup()
		setupWeatherBubbles()
	}

	
	//MARK: - General UI setup
	func UISetup() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .blue
		//Background Image
		addSubview(backgroundImage)
		backgroundImage.image = viewDesignManager.getBackgroundImage()
		//Search Field
		addSubview(searchField)
		searchField.backgroundColor = viewDesignManager.getFadedBlack()
		addSubview(searchButton)
		searchField.layer.cornerRadius = 5
		//City Temp label
		addSubview(cityTempLabel)
		//Weather Condition Label
		addSubview(weatherCondition)
		//greeting Label
		addSubview(greetingLabel)
		greetingLabel.text = viewDesignManager.getGreeting()
		//Location Button
		addSubview(locationButton)
		
		
		NSLayoutConstraint.activate([
			//Background Image
			backgroundImage.topAnchor.constraint(equalTo: topAnchor),
			backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
			backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
			//Search Field
			searchField.topAnchor.constraint(equalTo: topAnchor, constant: 60),
			searchField.widthAnchor.constraint(equalToConstant: 375),
			searchField.heightAnchor.constraint(equalToConstant: 37),
			searchField.centerXAnchor.constraint(equalTo: centerXAnchor),
			//Search Button
			searchButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
			searchButton.trailingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: -10),
			//City Temp Label
			cityTempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 160),
			cityTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 7),
			//Weather Condition Label
			weatherCondition.topAnchor.constraint(equalTo: cityTempLabel.bottomAnchor, constant: 10),
			weatherCondition.centerXAnchor.constraint(equalTo: centerXAnchor),
			//Greeting Label
			greetingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 325),
			greetingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			//Location Button
			locationButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 170),
			locationButton.topAnchor.constraint(equalTo: topAnchor, constant: 101),
			locationButton.widthAnchor.constraint(equalToConstant: 100),
			locationButton.heightAnchor.constraint(equalToConstant: 100)
		])
	}
	
	//MARK: - Weather Bubbles setup
	func setupWeatherBubbles() {
		//Stack View
		addSubview(hourlyWeatherStack)
		
		//Misc Weather Bubble One
		addSubview(highLowBubble)
			//Box Title
		highLowBubble.boxTitle.text = "High & Low"
			//Box Icon
		highLowBubble.boxIcon.image = UIImage(systemName: "thermometer.sun")
			//H LABEL
		highLowBubble.addSubview(highLowHLabel)
		highLowHLabel.textColor = viewDesignManager.getSixtyWhite()
			//L Label
		highLowBubble.addSubview(highLowLLabel)
		highLowLLabel.textColor = viewDesignManager.getSixtyWhite()
	
		
		//Misc Weather Bubble Two
		addSubview(riseAndSetBubble)
			//Box Title
		riseAndSetBubble.boxTitle.text = "Sun Rise & Set"
			//Box Icon
		riseAndSetBubble.boxIcon.image = UIImage(systemName: "sun.and.horizon")
			//SUN RISE ICON
		riseAndSetBubble.addSubview(sunriseImage)
		sunriseImage.tintColor = viewDesignManager.getSixtyWhite()
			//SUN DOWN ICON
		riseAndSetBubble.addSubview(sunsetImage)
		sunsetImage.tintColor = viewDesignManager.getSixtyWhite()
			//Details

		
		
		//Misc Weather Bubble Three
		addSubview(windSpeedBubble)
			//Box Title
		windSpeedBubble.boxTitle.text = "Wind"
			//Box Icon
		windSpeedBubble.boxIcon.image = UIImage(systemName: "wind")
			//Details

		
		
		NSLayoutConstraint.activate([
			//Weather Stack
			hourlyWeatherStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
			hourlyWeatherStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			hourlyWeatherStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 260),
			hourlyWeatherStack.heightAnchor.constraint(equalToConstant: 112),
			
			
			//Misc Weather Bubble One
			highLowBubble.topAnchor.constraint(equalTo: hourlyWeatherStack.bottomAnchor, constant: 7),
			highLowBubble.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
				//Box Icon
			highLowBubble.boxIcon.widthAnchor.constraint(equalToConstant: 9),
			highLowBubble.boxIcon.topAnchor.constraint(equalTo: highLowBubble.topAnchor, constant: 3),
			highLowBubble.boxIcon.leadingAnchor.constraint(equalTo: highLowBubble.leadingAnchor, constant: 10),
				//Box Title
			highLowBubble.boxTitle.centerYAnchor.constraint(equalTo: highLowBubble.boxIcon.centerYAnchor, constant: -1),
			highLowBubble.boxTitle.leadingAnchor.constraint(equalTo: highLowBubble.boxIcon.trailingAnchor, constant: 4),
				//Box Detail One
			highLowBubble.boxDetailOne.topAnchor.constraint(equalTo: highLowBubble.boxTitle.bottomAnchor, constant: 5),
			highLowBubble.boxDetailOne.leadingAnchor.constraint(equalTo: highLowBubble.leadingAnchor, constant: 28),
				//Box Detail Two
			highLowBubble.boxDetailTwo.topAnchor.constraint(equalTo: highLowBubble.boxDetailOne.bottomAnchor, constant: 3),
			highLowBubble.boxDetailTwo.leadingAnchor.constraint(equalTo: highLowBubble.boxDetailOne.leadingAnchor),
				//H Label
			highLowHLabel.topAnchor.constraint(equalTo: highLowBubble.boxTitle.bottomAnchor, constant: 5),
			highLowHLabel.leadingAnchor.constraint(equalTo: highLowBubble.leadingAnchor, constant: 15),
				//L Label
			highLowLLabel.topAnchor.constraint(equalTo: highLowHLabel.bottomAnchor, constant: 2),
			highLowLLabel.leadingAnchor.constraint(equalTo: highLowHLabel.leadingAnchor),
			
			
			//Misc Weather Bubble Two
			riseAndSetBubble.centerYAnchor.constraint(equalTo: highLowBubble.centerYAnchor),
			riseAndSetBubble.leadingAnchor.constraint(equalTo: highLowBubble.trailingAnchor, constant: 5),
				//Box Icon
			riseAndSetBubble.boxIcon.widthAnchor.constraint(equalToConstant: 15),
			riseAndSetBubble.boxIcon.topAnchor.constraint(equalTo: riseAndSetBubble.topAnchor, constant: 2),
			riseAndSetBubble.boxIcon.leadingAnchor.constraint(equalTo: riseAndSetBubble.leadingAnchor, constant: 8),
				//Box Title
			riseAndSetBubble.boxTitle.centerYAnchor.constraint(equalTo: riseAndSetBubble.boxIcon.centerYAnchor),
			riseAndSetBubble.boxTitle.leadingAnchor.constraint(equalTo: riseAndSetBubble.boxIcon.trailingAnchor, constant: 2),
				//Box Detail One
			riseAndSetBubble.boxDetailOne.topAnchor.constraint(equalTo: riseAndSetBubble.boxTitle.bottomAnchor, constant: 5),
			riseAndSetBubble.boxDetailOne.leadingAnchor.constraint(equalTo: riseAndSetBubble.leadingAnchor, constant: 28),
				//Box Detail Two
			riseAndSetBubble.boxDetailTwo.topAnchor.constraint(equalTo: riseAndSetBubble.boxDetailOne.bottomAnchor, constant: 3),
			riseAndSetBubble.boxDetailTwo.leadingAnchor.constraint(equalTo: riseAndSetBubble.boxDetailOne.leadingAnchor),
				//Sun Rise Icon
			sunriseImage.topAnchor.constraint(equalTo: riseAndSetBubble.boxTitle.bottomAnchor, constant: -1),
			sunriseImage.leadingAnchor.constraint(equalTo: riseAndSetBubble.leadingAnchor, constant: 11),
			sunriseImage.widthAnchor.constraint(equalToConstant: 14),
				//Sun Down Icon
			sunsetImage.topAnchor.constraint(equalTo: sunriseImage.bottomAnchor, constant: -6),
			sunsetImage.leadingAnchor.constraint(equalTo: riseAndSetBubble.leadingAnchor, constant: 11),
			sunsetImage.widthAnchor.constraint(equalToConstant: 14),
			
			
			//Misc Weather Bubble Three
			windSpeedBubble.centerYAnchor.constraint(equalTo: highLowBubble.centerYAnchor),
			windSpeedBubble.leadingAnchor.constraint(equalTo: riseAndSetBubble.trailingAnchor, constant: 5),
			
			//Box Icon
			windSpeedBubble.boxIcon.widthAnchor.constraint(equalToConstant: 15),
			windSpeedBubble.boxIcon.topAnchor.constraint(equalTo: windSpeedBubble.topAnchor, constant: 3),
			windSpeedBubble.boxIcon.leadingAnchor.constraint(equalTo: windSpeedBubble.leadingAnchor, constant: 8),
			//Box Title
			windSpeedBubble.boxTitle.centerYAnchor.constraint(equalTo: windSpeedBubble.boxIcon.centerYAnchor),
			windSpeedBubble.boxTitle.leadingAnchor.constraint(equalTo: windSpeedBubble.boxIcon.trailingAnchor, constant: 3),
			//Box Detail One
			windSpeedBubble.boxDetailOne.topAnchor.constraint(equalTo: windSpeedBubble.boxTitle.bottomAnchor, constant: 5),
			windSpeedBubble.boxDetailOne.leadingAnchor.constraint(equalTo: windSpeedBubble.leadingAnchor, constant: 20),
			//Box Detail Two
			windSpeedBubble.boxDetailTwo.topAnchor.constraint(equalTo: windSpeedBubble.boxDetailOne.bottomAnchor, constant: 3),
			windSpeedBubble.boxDetailTwo.leadingAnchor.constraint(equalTo: windSpeedBubble.boxDetailOne.leadingAnchor),

			
			

			
		])
		
	}
	
	
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
