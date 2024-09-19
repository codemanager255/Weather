//
//  ViewController.swift
//  Weather
//
//  Created by Mac on 13/09/24.
//

import UIKit
import Combine

class WeatherDisplayVC: UIViewController {
    // MARK: - Properties
    private let vm = WeatherViewModel(networkManager: ApiCall())
    private var weatherDataCancellable: AnyCancellable?
    
    // MARK: - Views
    
    // MARK: - - Background

    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "clear_sky_background_day")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - - SearchBar
    
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Atlanta"
        return sb
    }()
    
    // MARK: - - Main Weather Display

    private lazy var weatherVStack: UIStackView = {
        let vs = UIStackView(arrangedSubviews: [
            locationLabel,
            degreesLabel,
            skyLabel,
            highLowHStack
        ])
        vs.translatesAutoresizingMaskIntoConstraints = false
        vs.axis = .vertical
        vs.alignment = .center
        vs.distribution = .fillProportionally
        return vs
    }()
    
    private lazy var locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Unknown"
        lbl.font = .systemFont(ofSize: 40, weight: .regular)
        lbl.shadowColor = .black
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var degreesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "N/A"
        lbl.font = .systemFont(ofSize: 70, weight: .regular)
        lbl.shadowColor = .black
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var skyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Unavailable"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.shadowColor = .black
        return lbl
    }()
    
    private lazy var highLowHStack: UIStackView = {
        let hs = UIStackView(arrangedSubviews: [
            highDegreesLabel,
            lowDegreesLabel
        ])
        hs.axis = .horizontal
        hs.spacing = 5
        hs.distribution = .fillEqually
        return hs
    }()
    
    private lazy var highDegreesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "H: "
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.shadowColor = .black
        return lbl
    }()
    
    private lazy var lowDegreesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "L: "
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.shadowColor = .black
        return lbl
    }()
    
    // MARK: - - Feels Like & Visibility
    
    private lazy var feelsLikeView: UIView = {
        let flv = UIView()
        flv.addSubview(feelsLikeContentVStack)
        flv.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        flv.layer.cornerRadius = 15
        return flv
    }()
    
    private lazy var feelsLikeContentVStack: UIStackView = {
        let vs = UIStackView(arrangedSubviews: [
            self.feelsLikeTitleHStack,
            self.feelsLikeTempLabel,
            self.feelsLikeDescriptionLabel
        ])
        vs.axis = .vertical
        vs.alignment = .leading
        vs.distribution = .fillProportionally
        vs.translatesAutoresizingMaskIntoConstraints = false
        return vs
    }()
    
    private lazy var feelsLikeTitleHStack: UIStackView = {
        let icon = UIImageView(image: UIImage(systemName: "thermometer.medium"))
        icon.tintColor = .white.withAlphaComponent(0.5)
        icon.contentMode = .scaleAspectFill
        let hs = UIStackView(arrangedSubviews: [
            icon,
            feelsLikeTitleLabel
        ])
        hs.axis = .horizontal
        hs.alignment = .leading
        hs.spacing = 5
        return hs
    }()
    
    private lazy var feelsLikeTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "FEELS LIKE"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .white.withAlphaComponent(0.7)
        return lbl
    }()
    
    private lazy var feelsLikeTempLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "N/A"
        lbl.font = .systemFont(ofSize: 30, weight: .regular)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var feelsLikeDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "N/A"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var visibilityView: UIView = {
        let vv = UIView()
        vv.addSubview(visibilityContentVStack)
        vv.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        vv.layer.cornerRadius = 15
        return vv
    }()
    
    private lazy var visibilityContentVStack: UIStackView = {
        let vs = UIStackView(arrangedSubviews: [
            self.visibilityTitleHStack,
            self.visibilityDistanceLabel,
            self.visibilityDescriptionLabel
        ])
        vs.axis = .vertical
        vs.alignment = .leading
        vs.distribution = .fillProportionally
        vs.translatesAutoresizingMaskIntoConstraints = false
        return vs
    }()
    
    private lazy var visibilityTitleHStack: UIStackView = {
        let icon = UIImageView(image: UIImage(systemName: "eye.fill"))
        icon.tintColor = .white.withAlphaComponent(0.5)
        icon.contentMode = .scaleAspectFill
        let hs = UIStackView(arrangedSubviews: [
            icon,
            visibilityTitleLabel
        ])
        hs.axis = .horizontal
        hs.alignment = .leading
        hs.spacing = 3
        hs.distribution = .fillProportionally
        hs.translatesAutoresizingMaskIntoConstraints = false
        return hs
    }()
    
    private lazy var visibilityTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "VISIBILITY"
        lbl.font = .systemFont(ofSize: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white.withAlphaComponent(0.7)
        return lbl
    }()
    
    private lazy var visibilityDistanceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "N/A"
        lbl.font = .systemFont(ofSize: 30, weight: .regular)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var visibilityDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = " "
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var feelsVisHStack: UIStackView = {
        let hs = UIStackView(arrangedSubviews: [
            feelsLikeView,
            visibilityView
        ])
        hs.translatesAutoresizingMaskIntoConstraints = false
        hs.axis = .horizontal
        hs.spacing = 10
        hs.distribution = .fillEqually
        return hs
    }()
    

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        updateUIFields()
        do { try vm.getApiData() } catch { displayErrorAlert(error: error) }
    }
    
    
    // MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        // Constraints
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(weatherVStack)
        NSLayoutConstraint.activate([
            weatherVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            weatherVStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(feelsVisHStack)
        NSLayoutConstraint.activate([
            feelsVisHStack.topAnchor.constraint(equalTo: weatherVStack.bottomAnchor, constant: 50),
            feelsVisHStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsVisHStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            feelsVisHStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            feelsVisHStack.heightAnchor.constraint(equalToConstant: view.frame.width / 2 - 20)
        ])
        
        NSLayoutConstraint.activate([
            feelsLikeContentVStack.topAnchor.constraint(equalTo: feelsLikeView.topAnchor, constant: 15),
            feelsLikeContentVStack.trailingAnchor.constraint(equalTo: feelsLikeView.trailingAnchor, constant: -20),
            feelsLikeContentVStack.leadingAnchor.constraint(equalTo: feelsLikeView.leadingAnchor, constant: 20),
            feelsLikeContentVStack.bottomAnchor.constraint(equalTo: feelsLikeView.bottomAnchor, constant: -15),
            feelsLikeTitleHStack.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        NSLayoutConstraint.activate([
            visibilityContentVStack.topAnchor.constraint(equalTo: visibilityView.topAnchor, constant: 15),
            visibilityContentVStack.trailingAnchor.constraint(equalTo: visibilityView.trailingAnchor, constant: -20),
            visibilityContentVStack.leadingAnchor.constraint(equalTo: visibilityView.leadingAnchor, constant: 20),
            visibilityContentVStack.bottomAnchor.constraint(equalTo: visibilityView.bottomAnchor, constant: -15),
            visibilityTitleHStack.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    func displayErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: String(describing: error), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUIFields() {
        weatherDataCancellable = vm.$weatherData.sink(receiveValue: { weatherData in
            guard let _weatherData = weatherData else {return}
            self.locationLabel.text = _weatherData.name
            self.degreesLabel.text = "\(Int(self.vm.kelvinToFarenheit(kelvin: _weatherData.main.temp)))°"
            self.skyLabel.text = _weatherData.weather.first?.description.capitalized
            self.highDegreesLabel.text = "H:\(Int(self.vm.kelvinToFarenheit(kelvin: _weatherData.main.tempMax)))°"
            self.lowDegreesLabel.text = "L:\(Int(self.vm.kelvinToFarenheit(kelvin: _weatherData.main.tempMin)))°"
            self.feelsLikeTempLabel.text = "\(Int(self.vm.kelvinToFarenheit(kelvin: _weatherData.main.feelsLike)))°"
            
            if _weatherData.main.temp < _weatherData.main.feelsLike {
                self.feelsLikeDescriptionLabel.text = "Humidity is making it feel hotter."
            } else { self.feelsLikeDescriptionLabel.text = "It feels cooler than it is."}
            
            self.visibilityDistanceLabel.text = "\(_weatherData.visibility / 1609) mi"
        })
    }
}


// MARK: - Extensions

extension WeatherDisplayVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: implement update on weather data for search result
    }
}
