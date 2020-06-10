//
//  DetailMapTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/29/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import MapKit

class DetailMapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
