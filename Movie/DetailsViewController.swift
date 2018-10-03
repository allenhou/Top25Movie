//
//  DetailsViewController.swift
//  Movie
//
//  Created by Allen Hou on 9/29/18.
//  Copyright © 2018 nEmmY. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movie: Movie?
    
    //Mark: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryText: UITextView!
    
    //Mark: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movie = movie{
            titleLabel.text = movie.name
            categoryLabel.text = movie.category
            artistLabel.text = movie.artist
            summaryText.text = movie.summary
            let url = URL(string: movie.image170url)!
            let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.poster.image = image
                    }
                }
            }
            session.resume()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
