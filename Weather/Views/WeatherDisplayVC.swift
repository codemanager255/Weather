//
//  ViewController.swift
//  Weather
//
//  Created by Mac on 13/09/24.
//

import UIKit

class WeatherDisplayVC: UIViewController {
    // MARK: - Properties
    //private let vm = ViewModel()
    
    
    // MARK: - Views
    
    // MARK: - - Background
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "clear_sky_background_day")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        lbl.text = "Atlanta"
        lbl.font = .systemFont(ofSize: 30, weight: .regular)
        lbl.shadowColor = .black
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var degreesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "82°"
        lbl.font = .systemFont(ofSize: 60, weight: .thin)
        lbl.shadowColor = .black
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var skyLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mostly Cloudy"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
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
        lbl.text = "H:82°"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        lbl.shadowColor = .black
        return lbl
    }()
    
    private lazy var lowDegreesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "L:63°"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 15, weight: .semibold)
        lbl.shadowColor = .black
        return lbl
    }()
    
    // MARK: - - Feels Like & Visibility
    
    private lazy var feelsLikeView: UIView = {
        let flv = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.frame.width/2 - 50, height: view.frame.width/2 - 50)))
        flv.backgroundColor = .white.withAlphaComponent(0.5)
        flv.layer.cornerRadius = 10
        return flv
    }()
    
    private lazy var visibilityView: UIView = {
        let vv = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.frame.width/2 - 50, height: view.frame.width/2 - 50)))
        vv.backgroundColor = .systemFill
        vv.layer.cornerRadius = 10
        return vv
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
    }
    
    
    // MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
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
            feelsVisHStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

