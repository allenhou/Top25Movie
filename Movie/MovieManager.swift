//
//  MovieManager.swift
//  Movie
//
//  Created by Allen Hou on 9/30/18.
//  Copyright © 2018 nEmmY. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func didLoadMovies()
}


class MovieManger {
    
    var movies = [Movie]()
    var delegate : MovieManagerDelegate? = nil
    
    func loadMovies() {
        let itunes = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        guard let url = URL(string: itunes) else {
            print("invalid URL")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSON(data: data!)
                let entries = json["feed"]["entry"].array!
                
                for entry in entries{
                    let name = entry["im:name"]["label"].string!
                    let summary = entry["summary"]["label"].string!
                    let category = entry["category"]["attributes"]["label"].string!
                    let image60url = entry["im:image"][0]["label"].string!
                    let image170url = entry["im:image"][2]["label"].string!
                    let artist = entry["im:artist"]["label"].string!
                    let id = entry["id"]["attributes"]["im:id"].string!
                    
                    let movie = Movie(name: name,
                                      summary: summary,
                                      category: category,
                                      image60url: image60url,
                                      image170url: image170url,
                                      artist: artist,
                                      id: id)
                    
                    self.movies.append(movie)
                }
                
                if let delegate = self.delegate{
                    DispatchQueue.main.async {
                        delegate.didLoadMovies()
                    }
                }
                
            } catch{
                print("JSON invalid")
            }
        }
        session.resume()
    }
    
    
}
