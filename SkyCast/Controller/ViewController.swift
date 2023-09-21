//
//  ViewController.swift
//  Sky Cast
//
//  Created by Daniel Efrain Ocasio on 8/9/23.
//
import Foundation
import UIKit
import CoreLocation

class ViewController: UIViewController {
	
	//Handles the appearace of the view
	let weatherView = WeatherView()
	
	//Handles the API fetch
	let weatherManager = WeatherDataManager()
	
	//Handles the users location fetch
	let locationManager = CLLocationManager()
	
	//Handles Design; Colors, Text to show, background etc.
	let designManager = ViewDesignManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManagerSetup()
		
		setupUI()
	}
	

	//MARK: - Initial UI setup
	//This function does some of the extra UI work such as gesture actions, and View positioning
	func setupUI() {
		view.addSubview(weatherView)
	
		//Search Field
		weatherView.searchField.delegate = self
		weatherView.searchField.returnKeyType = .search
		
		//Below makes it to where a function is called and the keyboard is dismissed when the user taps the search Button (Magnifying Glass)
		weatherView.searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
		let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
		view.addGestureRecognizer(tapDismiss)
		
		//Below makes it to where the locationTapped function is called when the locationButton is tapped
		weatherView.locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
		
		//View positioning
		NSLayoutConstraint.activate([
			weatherView.topAnchor.constraint(equalTo: view.topAnchor),
			weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	//MARK: - Update of UI with fetched data
	//This function takes the fetched Weather Data and updates all of the view except the hourly forecast portion, with the fetched data
	//Upper Main portion of screen and bubbles at bottom of screen
	func updateUI(weatherData: WeatherDataModel) {
		
		DispatchQueue.main.async { [self] in
			//Main Portion of Screen
			let address = weatherData.resolvedAddress
			let components = address.components(separatedBy: ",")
			let cityName = components.first?.trimmingCharacters(in: .whitespaces)
			
			weatherView.cityTempLabel.text = "\(cityName!)\n\(Int(weatherData.currentConditions.temp))°"
			weatherView.weatherCondition.text = "\(weatherData.currentConditions.conditions)"
		
			//Bubbles at bottom of screen (Bottom Portion)
				//Daily High and Lows bubble
			weatherView.highLowBubble.boxDetailOne.text = ("\(Int(weatherData.days.first!.tempmax))°")
			weatherView.highLowBubble.boxDetailTwo.text = ("\(Int(weatherData.days.first!.tempmin))°")
			
				//Sun Rise and Set Bubble
					//Here we take the dates fetched and convert them into Date Objects
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "HH:mm:ss"
			let sunriseUnformatted = dateFormatter.date(from: weatherData.currentConditions.sunrise)
			let sunsetUnformatted = dateFormatter.date(from: weatherData.currentConditions.sunset)
					// Here we take the converted Date Objects from previous step and change the format
					// To be standard 12 hour time and only show hours and minutes
					// Then convert them back to Strings; results are stored in constants and set to appear on screen
			let timeFormatter = DateFormatter()
			timeFormatter.dateFormat = "h:mm"
			timeFormatter.locale = Locale(identifier: "en_US")
			let sunriseTime = timeFormatter.string(from: sunriseUnformatted!)
			let sunsetTime = timeFormatter.string(from: sunsetUnformatted!)
			
			weatherView.riseAndSetBubble.boxDetailOne.text = ("\(sunriseTime) am")
			weatherView.riseAndSetBubble.boxDetailTwo.text = ("\(sunsetTime) pm")
			
				//Wind Speed Bubble
			weatherView.windSpeedBubble.boxDetailOne.text = ("\(Int(weatherData.currentConditions.windspeed)) mph")
			
			//Finally this calls the function that handles the Hourly Forecast view, passing the weatherData for further use
			createHourlyView(weatherData: weatherData)
		}
	}
	
	//MARK: - Hourly Section Creation
	//The below function handles the setup of the Hourly Forecast View (hourlyView)
	func createHourlyView(weatherData: WeatherDataModel) {
		//Gets the users current hour
		let now = Date()
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: now)
		
		//Creates a Date Formmatter with a standard format and then another with a format of   Hour pm/am
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm:ss"
		let timeFormatter = DateFormatter()
		timeFormatter.dateFormat = "ha"
		
		//Goes through and removes any views that may be in the hourlyView to start with a blank slate
		for subview in weatherView.hourlyWeatherStack.arrangedSubviews {
			weatherView.hourlyWeatherStack.removeArrangedSubview(subview)
			subview.removeFromSuperview()
		}
		
		//Loop that gets ran through Six times getting the next next hour each time (using index)
		//Creating its own hourlyView each time
		for index in 0...5 {
			//Creates the hourlyView ad sets its size constraints
			let hourlyView = HourlyWeatherView()
			hourlyView.widthAnchor.constraint(equalToConstant: 53).isActive = true
			hourlyView.heightAnchor.constraint(equalToConstant: 112).isActive = true

			//This creates a constant that adds index to the hour so that for each loop it gets the next hour
			let loopHour = (hour + index)
			
			//Checkes if loophour becomes equal to or over 24
			//Using this constant an if statement is used to check if isTomorrow is true
			//And if it is, it gets data from the following day beginning from [0] (12AM)
			//Else the current days data is used
			let isTomorrow = loopHour >= 24
			
			if isTomorrow == true {
				let altLoopHour = loopHour - 24
			
				hourlyView.temperatureLabel.text = "\(Int(weatherData.days[1].hours[altLoopHour].temp))°"
				
				let unformattedTime = dateFormatter.date(from: weatherData.days[1].hours[altLoopHour].datetime)
				let formattedTime = timeFormatter.string(from: unformattedTime!)
				hourlyView.timeLabel.text = "\(formattedTime)"
				
				if weatherData.days[1].hours[altLoopHour].precipprob >= 10 {
					hourlyView.rainlabel.text = "\(Int(weatherData.days[1].hours[altLoopHour].precipprob))%"
				} else {
					hourlyView.rainlabel.text = ""
				}
				
				hourlyView.weatherIcon.image = UIImage(named: weatherData.days[1].hours[altLoopHour].icon)
					
				weatherView.hourlyWeatherStack.addArrangedSubview(hourlyView)
				
			} else {
				
				hourlyView.temperatureLabel.text = "\(Int(weatherData.days[0].hours[loopHour].temp))°"
				
				let unformattedTime = dateFormatter.date(from: weatherData.days[0].hours[loopHour].datetime)
				let formattedTime = timeFormatter.string(from: unformattedTime!)
				hourlyView.timeLabel.text = "\(formattedTime)"
				
				if weatherData.days[0].hours[loopHour].precipprob >= 10 {
					hourlyView.rainlabel.text = "\(Int(weatherData.days[0].hours[loopHour].precipprob))%"
				} else {
					hourlyView.rainlabel.text = ""
				}
				
				hourlyView.weatherIcon.image = designManager.weatherIcon["\(weatherData.days[0].hours[loopHour].icon)"]!
				
				weatherView.hourlyWeatherStack.addArrangedSubview(hourlyView)
			}
		}
	}
	
	//MARK: - Action called Functions
	
	//the function called when the magnifying glass seach button is tapped
	@objc func searchTapped() {
		fetchWeather(locale: weatherView.searchField.text!)
	}
	
	//Function called when the location button is tapped
	@objc func locationTapped() {
		locationManager.requestLocation()
	}
	
	func fetchWeather(locale: String) {
		weatherManager.fetchWeather(location: locale)
		
		weatherManager.passWeather = {weatherData in
			self.handlePassedData(weatherData: weatherData)
		}
		view.endEditing(true)
		
		weatherView.searchField.text = ""
		
	}
	
	//Makes it to where when the screen is tapped the keyboard is dismissed
	@objc func screenTapped() {
		view.endEditing(true)
	}
	
	//This is the closure where data from the weather manager is passed.
	//Calls a function that takes the weather Data and updates the view
	func handlePassedData(weatherData: WeatherDataModel) {
		updateUI(weatherData: weatherData)
		
	}
	

}

//MARK: - Extension for the Location manager and the search field delegate

extension ViewController: UITextFieldDelegate, CLLocationManagerDelegate {
	
	func locationManagerSetup() {
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	
	//function called when the users location is updated
	//When this is calledit takes the location and gets revereGeocodes it
	//so we can get ahold of the specific city the user is in
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		locationManager.stopUpdatingLocation()

		guard let location = locations.first else {
			return
		}
		
		
		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(location) { placeMark, error in
			
			let placeMark = placeMark?.first
			guard let country = placeMark?.administrativeArea else {
				return
			}
			
			guard let city = placeMark?.locality else {
				return
			}
			//calls fetchweather using the city,
			//also add country in there for accurate results from the api
			self.fetchWeather(locale: "\(city) \(country)")
			print(city)
		}
		
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error")
	}
	
	//Calls fetchweather with the text inside of the searchfield when the return/search key is tapped
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		fetchWeather(locale: weatherView.searchField.text!)
		return true
	}
	
}

