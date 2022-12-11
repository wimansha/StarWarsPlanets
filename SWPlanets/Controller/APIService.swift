//
//  APIService.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-26.
//

import Foundation

class APIService {
    
    //MARK: --- Constants ---
    
    public static let shared = APIService()
    
    //MARK: --- Public Properties ---
    
    public let planets = [Planet]()
    
    //MARK: --- Public Methods ---
    
    func loadPlanets(completion : @escaping (_ lessons : [Planet]?, _ error : Error?) -> Void) {
        let urlString = "https://swapi.dev/api/planets/"
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, errorr) in
            DispatchQueue.main.async {
                if let _ = errorr {
                    completion(nil,errorr)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(nil,nil)
                    return
                }
                guard let data = data else {
                    completion(nil,nil)
                    return
                }
                do {
                    let deconder = JSONDecoder()
                    deconder.keyDecodingStrategy = .convertFromSnakeCase
                    let planetsPack = try deconder.decode(PlanetsPack.self, from: data)
                    completion(planetsPack.results,nil)
                } catch {
                    completion(nil,error)
                }
            }
        }
        task.resume()
    }
}
