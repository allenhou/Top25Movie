//
//  ViewController.swift
//  Movie
//
//  Created by Allen Hou on 9/29/18.
//  Copyright © 2018 nEmmY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieManagerDelegate {
    
    var array = [Movie]()
    let movieManager = MovieManger()
    
    //MARK: - MovieManager Delegate
    func didLoadMovies() {
        tableView.reloadData()
    }
    
    //Mark: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    //Mark: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieManager.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieTableViewCell
        
        let movie = movieManager.movies[indexPath.row]
        cell.titleLabel.text = movie.name
        cell.yearLabel.text = movie.category
        let url = URL(string: movie.image60url)!
        let session = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    cell.setNeedsLayout()
                }
            }
        }
        session.resume()
        return cell
    }
    
    //Mark: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        movieManager.delegate = self
        movieManager.loadMovies()
        
//        array.append(Movie(name: "2001: A space oddyssey", year: 1968, director: "Stanley Kubrick"))
//        array.append(Movie(name: "Logan's Run", year: 1976, director: "Michael Anderson"))
//        array.append(Movie(name: "This is Spinal Tap", year: 1984, director: "Rob Reiner"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Mark: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! DetailsViewController
                destVC.movie = movieManager.movies[indexPath.row]
            }
        }
    }

}

