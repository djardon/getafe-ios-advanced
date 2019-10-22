//
//  UserDetailMapViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 21/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit
import MapKit

class UserDetailMapViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserDetailMapViewCell.self)
    static let cellHeight: CGFloat = 300

    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    private let regionRadius: CLLocationDistance = 500
    // Test Data
    private let barcelonaLocation = CLLocation(latitude: 41.381653,
                                            longitude: 2.123764)
    private let madridLocation = CLLocation(latitude: 40.454148,
                                               longitude: -3.688387)
    

    override func prepareForReuse() {
        mapView.delegate = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapView.layer.cornerRadius = 8.0
        mView.layer.cornerRadius = 8.0
        mView.configureShadows()
        
        mapView.delegate = self
    }
    
    
    func configure(latitude: String? = nil, longitude: String? = nil) {
        guard let locationLatitude = Double(latitude ?? ""),
              let locationLongitude = Double(longitude ?? "") else {
            return
        }

        let userLocation = CLLocation(latitude: locationLatitude,
                                      longitude: locationLongitude)
        //centerMapOn(location: madridLocation)
        //addUserMark(location: madridLocation)
        showRouteOnMap(originCoordinates: madridLocation.coordinate,
                       destinationCoordinates: barcelonaLocation.coordinate)
    }
    
    private func centerMapOn(location: CLLocation) {
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate,
                                             latitudinalMeters: regionRadius,
                                             longitudinalMeters: regionRadius),
                          animated: true)
    }
    
    private func addUserMark(location: CLLocation) {
        mapView.addAnnotation(UserMarkAnnotation(title: "User name",
                                                 locationName: "calle, cp, ciudad, país",
                                                 coordinate: location.coordinate))
    }
}

class UserMarkAnnotation: NSObject, MKAnnotation {
    let locationName: String?
    let title: String?
    let coordinate: CLLocationCoordinate2D
    var subtitle: String? {
        return locationName
    }
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
}

class OverlayPolyline: MKPolyline {
    var isDefault: Bool = false
}

extension UserDetailMapViewCell: MKMapViewDelegate {

    func showRouteOnMap(originCoordinates: CLLocationCoordinate2D,
                        destinationCoordinates: CLLocationCoordinate2D) {
        let originPlacemark = MKPlacemark(coordinate: originCoordinates,
                                          addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates,
                                               addressDictionary: nil)
        
        addAnnotationPlacemarks(origin: originPlacemark,
                                destination: destinationPlacemark)
        
        let directionsRequest = directions(from: MKMapItem(placemark: originPlacemark),
                                           to: MKMapItem(placemark: destinationPlacemark))
        
        calculateDirections(request: directionsRequest)
    }
    
    private func addAnnotationPlacemarks(origin: MKPlacemark, destination: MKPlacemark) {
        let originAnnotation = MKPointAnnotation()
        originAnnotation.coordinate = origin.coordinate
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destination.coordinate
        
        mapView.showAnnotations([originAnnotation, destinationAnnotation],
                                animated: true)
    }
    
    private func directions(from: MKMapItem, to: MKMapItem) -> MKDirections {
        let requestDirections = MKDirections.Request()
        requestDirections.source = from
        requestDirections.destination = to
        requestDirections.requestsAlternateRoutes = true
        requestDirections.transportType = .automobile
        
        return MKDirections(request: requestDirections)
    }
    
    private func calculateDirections(request: MKDirections) {
        guard !request.isCalculating else {
            return
        }
        
        request.calculate { response, error in
            guard let responseData = response else {
                return
            }
            
            responseData.routes.enumerated().forEach { index, route in
                let polyline: OverlayPolyline = OverlayPolyline(points: route.polyline.points(),
                                                                count: route.polyline.pointCount)
                polyline.isDefault = index == 0 ? true:false
                
                
                self.mapView.addOverlay(polyline,
                                        level: .aboveRoads) }
        }
    }
    
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        if let overlayAnnotation = overlay as? OverlayPolyline {
            renderer.strokeColor = overlayAnnotation.isDefault ? UIColor.systemBlue:UIColor.systemGray
        }
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
}
