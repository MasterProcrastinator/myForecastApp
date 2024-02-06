//
//  ViewController.swift
//  myForecastApp
//
//  Created by ALVIN CHEN on 1/26/24.
//

import UIKit

struct Weather: Codable{
    var list: [Weather2]
}
struct Weather2: Codable{
    var main: Weather3
    var dt: Double
    var weather: [Weather4]
}
struct Weather4: Codable{
    var main: String
    var description: String
}

struct Weather3: Codable{
    var temp: Double
    var humidity: Int
}

var day2 = [""]
var temperature = [""]
var humidity = [""]
var weather2 = [""]
var weatherDescription = [""]
var chooser = 0

class ViewController: UIViewController {

    @IBOutlet weak var descOutlet: UILabel!
    
    @IBOutlet weak var weatherOutlet: UILabel!
    
    @IBOutlet weak var humidOutlet: UILabel!
    
    @IBOutlet weak var temperatureOutlet: UILabel!
    
    @IBOutlet weak var dayOutlet: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
        
        descOutlet.text = weatherDescription[chooser]
        temperatureOutlet.text = temperature[chooser]
        humidOutlet.text = humidity[chooser]
        weatherOutlet.text = weather2[chooser]
        dayOutlet.text = day2[chooser]
        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: UIButton) {
        if(chooser != 1){
            chooser = chooser - 1
        }
        descOutlet.text = weatherDescription[chooser]
        temperatureOutlet.text = temperature[chooser]
        humidOutlet.text = humidity[chooser]
        weatherOutlet.text = weather2[chooser]
        dayOutlet.text = day2[chooser]
    }
    @IBAction func nextAction(_ sender: UIButton) {
        if(chooser < 5){
            chooser += 1
        }
        descOutlet.text = weatherDescription[chooser]
        temperatureOutlet.text = temperature[chooser]
        humidOutlet.text = humidity[chooser]
        weatherOutlet.text = weather2[chooser]
        dayOutlet.text = day2[chooser]
    }
    
    func getWeather(){
        
        let session = URLSession.shared
        
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=44.24&lon=-88.32&units=imperial&appid=3fec9efc5efff4a92b78d3275faaa7c6")
        
        print("data")
        
        let dataTask = session.dataTask(with: weatherURL!) { [self] (data:Data?, response:URLResponse?, error:Error?) in
            if let e = error{
                print("\(e)")
            }
            
            else{
                
                if let d = data{
                    print("found data")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary{
                        print("\(jsonObj)")
                        
                        
                        
                if let weatherObj = try? JSONDecoder().decode(Weather.self, from: d){
                    var x = 0
                    while(x<40){
                        
                        //day2.append("day: \(weatherObj.list[x].dt)")
                        
                        
                        let Date = Date(timeIntervalSince1970: weatherObj.list[x].dt)
                            let formatter = DateFormatter()
                            formatter.dateStyle = .medium
                        formatter.timeStyle = .none
                        
                        let formattedTime = formatter.string(from: Date)
                           print(formattedTime)
                           DispatchQueue.main.async {
                               day2.append("\(formattedTime)")

                           }
                        
                        
                        
                        
                        
                        
                        
                        
                        temperature.append("temp: \(Int(weatherObj.list[x].main.temp.rounded())) Fahrenheit")
                        humidity.append("humidity: \(weatherObj.list[x].main.humidity)")
                        weather2.append("weather: \(weatherObj.list[x].weather[0].main)")
                        weatherDescription.append("weather description: \(weatherObj.list[x].weather[0].description)")
                        
                        x+=8
                    }
                    }
                        
                else{
                print("error decoding")
                }
                        
                        
                        
                        
                        
                    }
                }
                
                
                else{
                    print("can't find data")
                }
                
            }
        }
        

        dataTask.resume()
        
        
    }
}

