//
//  DataManager.swift
//  Weather App
//
//  Created by Daniel Efrain Ocasio on 8/9/23.
//

import Foundation
import Combine



class WeatherDataManager {
	
	//closure which will be used to pass the weatherData
	//once the Api Request is completed
	var passWeather: ((WeatherDataModel) -> Void)?
	
	//Stores any cancellable in a variable
	private var cancellable: AnyCancellable?
		
	//function called to fetch the weather
	//takes location of type string as an input-
	//Then used in the urlstring for the fetch
	func fetchWeather(location: String) {
		
		let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		
		let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(encodedLocation!)/?key=QNMAYLGMMRC6KNWDUUXJJZJ7R#"
		
		 cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
			.map(\.data)
			.decode(type: WeatherDataModel.self, decoder: JSONDecoder())
			.sink(receiveCompletion: {completion in
				print("Network request status returned: \(completion)")}
				  , receiveValue: {data in
				manageWeather(weatherData: data)
			
			})
		
		//function called at the end of fetch weather when
		//The fetch has concluded, passing the fetched data here.
		//This function then prints and handles passing the weather to VC
		func manageWeather(weatherData: WeatherDataModel) {
			print(weatherData)
			
			passWeather!(weatherData)
			
		}
	}
}
