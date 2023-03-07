//
//  DetailsViewController.swift
//  LandmarksList
//
//  Created by lpiem on 28/02/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var landmarkTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var park: UILabel!
    @IBOutlet weak var landmarkDescription: UILabel!
    var landmark: Landmark?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        landmarkTitle.text = landmark?.name
        image.image = landmark?.image
        state.text = landmark?.state
        city.text = landmark?.city
        park.text = landmark?.park
        landmarkDescription.text = landmark?.description
    }
    

}
