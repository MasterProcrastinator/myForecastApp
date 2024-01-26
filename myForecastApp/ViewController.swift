//
//  ViewController.swift
//  myForecastApp
//
//  Created by ALVIN CHEN on 1/26/24.
//

import UIKit

struct Weather1: Codable{
    var list: [Weather2]
}
struct Weather2: Codable{
    var main: Weather3
    var weather: Weather32
}
struct Weather3: Codable{
    var temp: Double
    var humidity: Int
}
    struct Weather32: Codable{
    var main: String
    var description: String
}




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
        // Do any additional setup after loading the view.
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
                        print("temp: \(weatherObj.list[x].main.temp)")
                        print("humidity: \(weatherObj.list[x].main.humidity)")
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

