//
//  ViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    //MARK: Properties
    var coordinate: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var collegeName: String = ""
    var buildingName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
      //Generate coordinate
      getCoordinate()
        
      // Create a GMSCameraPosition that tells the map to display the
      let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 19.0)
      let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
      mapView.settings.compassButton = true
      view = mapView

      // Creates a marker in the center of the map.
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      marker.title = collegeName
      marker.snippet = buildingName
      marker.map = mapView
    }

    //MARK: Private Methods
    private func getCoordinate() {
        let index = coordinate.firstIndex(of: ",")!
        let latitudeIndex = coordinate.index(before: index)
        let spaceIndex = coordinate.index(after: index)
        let longitudeIndex = coordinate.index(after: spaceIndex)
        
        latitude = Double(coordinate[...latitudeIndex]) as! Double
        longitude = Double(coordinate[longitudeIndex...]) as! Double
    }

}

