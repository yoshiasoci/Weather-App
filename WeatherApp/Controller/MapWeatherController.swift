//
//  MapWeatherController.swift
//  WeatherApp
//
//  Created by admin on 1/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class MapWeatherController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var weatherInfoButton: UIButton!
    
    var viewModelMapWeather: MapWeatherViewModelable
    init(viewModel: MapWeatherViewModelable) {
        self.viewModelMapWeather = viewModel
        super.init(nibName: "MapWeatherView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var city = BehaviorRelay<String?>(value: nil)
    var latitude = BehaviorRelay<Double?>(value: nil)
    var longitude = BehaviorRelay<Double?>(value: nil)
    
    var locationCoordinate: CLLocationCoordinate2D = .init()
    var currentLocation: CLLocation!
    var locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
    let disposeBag = DisposeBag()
    
    private func bindData(){
        
        self.city
            .bind(to: viewModelMapWeather.city)
            .disposed(by: disposeBag)
        
        self.latitude
            .bind(to: viewModelMapWeather.latitude)
            .disposed(by: disposeBag)
        
        self.longitude
            .bind(to: viewModelMapWeather.longitude)
            .disposed(by: disposeBag)
        
        self.weatherInfoButton.rx.tap
            .bind(to: viewModelMapWeather.weatherInfoButton)
            .disposed(by: disposeBag)
        
    }
    
    private func configurationView() {
        
        //add button in right navigation bar
        let buttonSearchLocation = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(showSearchButton))
        self.navigationItem.rightBarButtonItem  = buttonSearchLocation
        
        //tampilan button
        weatherInfoButton.backgroundColor = UIColor.lightGray
        weatherInfoButton.layer.cornerRadius = weatherInfoButton.frame.height / 3
        
        //set default location by current location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 1000
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            currentLocation = locationManager.location
        }
        
        if CLLocationManager.headingAvailable() {
            locationManager.headingFilter = 5
            locationManager.startUpdatingHeading()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        configurationView()
        //title navigation
        navigationItem.title = "Map"
        
        
    }
    
//    @IBAction func searchButton(_ sender: Any) {
//        self.mapView.removeAnnotation(self.annotation)
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        present(searchController, animated: true, completion: nil)
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start {
            (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("error")
            } else {
                let coordinate = response!.boundingRegion.center
                self.annotation.title = searchBar.text
                self.annotation.coordinate = coordinate
                self.mapView.addAnnotation(self.annotation)
                //self.city = searchBar.text!
                self.city.accept(searchBar.text)
                self.locationCoordinate = coordinate
                self.latitude.accept(coordinate.latitude)
                self.longitude.accept(coordinate.longitude)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        
        self.locationCoordinate = location.coordinate
        self.latitude.accept(location.coordinate.latitude)
        self.longitude.accept(location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.050, longitudeDelta: 0.050)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        fetchCityAndCountry(from: location, completion: { city, state, error in
            guard let city = city, let state = state, error == nil else { return }
            //self.city = city
            self.city.accept(city)
            self.annotation.title = city + ", " + state
            self.annotation.coordinate = location.coordinate
            self.mapView.addAnnotation(self.annotation)
        })
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ state:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) {
            placemarks, error in completion(placemarks?.first?.locality, placemarks?.first?.country, error)
        }
    }
    
    //implementasi button
    @objc func showSearchButton(){
        self.mapView.removeAnnotation(self.annotation)
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
}
