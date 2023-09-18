//
//  Model.swift
//  Weather App
//
//  Created by Daniel Efrain Ocasio on 8/9/23.
//

import Foundation

struct WeatherDataModel: Decodable {
	
	let address: String
	
	let resolvedAddress: String
	
	let days: [Days]
	
	let currentConditions: CurrentConditions
	
}


struct Days: Decodable {
	
	let tempmax: Double
	
	let tempmin: Double
	
	let temp: Double
	
	let humidity: Double
	
	let windspeed: Double
	
	let sunrise: String
	
	let sunset: String
	
	let conditions: String
	
	let hours: [Hours]
	
	}

struct Hours: Decodable {
	
	let datetime: String
	
	let temp: Double
	
	let precipprob: Double
	
	let icon: String
	
}

struct CurrentConditions: Decodable {
	
	let temp: Double
	
	let humidity: Double
	
	let windspeed: Double
	
	let conditions: String
	
	let sunrise: String
	
	let sunset: String
		
}
