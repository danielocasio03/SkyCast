//
//  ColorManager.swift
//  Sky Cast
//
//  Created by Daniel Efrain Ocasio on 8/21/23.
//

import Foundation
import UIKit

class ViewDesignManager {

	var backgroundImage: UIImage!
	
	var fadedBlack: UIColor
	
	var ninetyWhite: UIColor
	
	var sixtyWhite: UIColor
	
	var bubbleColor: UIColor
	
	var greeting: String!
	
	init() {
		
		//Here it gets  the UI's color and design scheme based off the time of day
		let now = Date()
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: now)
				
		if hour > 6 && hour < 12 {
			//Morning Color Scheme (6am - 11:59pm)
			greeting = "Good Morning"
			backgroundImage = UIImage(named: "DayPic")
			fadedBlack = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.15)
			ninetyWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
			sixtyWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.65)
			bubbleColor = UIColor(red: 23/255, green: 42/255, blue: 71/255, alpha: 0.4)
		} else if hour >= 12 && hour < 18 {
			//Afternoon color scheme (12pm - 5:59pm)
			greeting = "Good Afternoon"
			backgroundImage = UIImage(named: "DayPic")
			fadedBlack = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.15)
			ninetyWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
			sixtyWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.65)
			bubbleColor = UIColor(red: 23/255, green: 42/255, blue: 71/255, alpha: 0.4)
		}else {
			//Evening Scheme (6pm - 6am)
			greeting = "Good Evening"
			backgroundImage = UIImage(named: "NightPic")
			fadedBlack = UIColor(red: 35/255, green: 54/255, blue: 87/255, alpha: 0.25)
			ninetyWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
			sixtyWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.65)
			bubbleColor = UIColor(red: 23/255, green: 42/255, blue: 71/255, alpha: 0.4)
			
		}
	}
	
	//Functions called to get the results from the above if statement.
	//used to get the UI elements in respective classes
	func getGreeting() -> String {
		return greeting
	}
	
	func getBackgroundImage() -> UIImage? {
		return backgroundImage
	}
	
	func getFadedBlack() -> UIColor? {
		return fadedBlack
	}
	
	func getninetyWhite() -> UIColor? {
		return ninetyWhite
	}
	
	func getSixtyWhite() -> UIColor? {
		return sixtyWhite
	}
	
	func getBubbleColor() -> UIColor? {
		return bubbleColor
	}
	
	//Dictionary for converting the weather descrption to icons for use in the hourly forecast
	
	let weatherIcon: [String:UIImage?] = [

		"snow":UIImage(systemName: "cloud.snow"),

		"snow-showers-day":UIImage(systemName: "cloud.snow"),

		"snow-showers-night":UIImage(systemName: "cloud.snow"),

		"thunder-rain":UIImage(systemName: "cloud.snow"),
			
		"thunder-showers-day":UIImage(systemName: "cloud.bolt.rain"),

		"thunder-showers-night": UIImage(systemName: "cloud.bolt.rain"),

		"rain":UIImage(systemName: "cloud.rain"),

		"showers-day":UIImage(systemName: "cloud.rain"),

		"showers-night":UIImage(systemName: "cloud.rain"),

		"fog":UIImage(systemName: "cloud.fog"),

		"wind":UIImage(systemName: "wind"),

		"cloudy":UIImage(systemName: "cloud"),

		"partly-cloudy-day":UIImage(systemName: "cloud.sun"),

		"partly-cloudy-night":UIImage(systemName: "cloud.moon"),

		"clear-day":UIImage(systemName: "sun.max"),

		"clear-night":UIImage(systemName: "moon"),

	]

}
