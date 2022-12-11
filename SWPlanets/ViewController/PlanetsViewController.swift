//
//  PlanetsViewController.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-25.
//

import UIKit
import SwiftUI

class PlanetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private enum State {
        case loading
        case loaded
        case loadingFailed
    }
    
    //MARK: --- Properties ---
    
    private var state: State = .loading {
        didSet {
            switch state {
            case .loading :
                loadingIndicator.startAnimating()
                loadingFailedView.isHidden = true
            case .loaded :
                loadingIndicator.stopAnimating()
                loadingFailedView.isHidden = true
            case .loadingFailed :
                loadingIndicator.stopAnimating()
                loadingFailedView.isHidden = false
            }
        }
    }
    
    private var planets = [Planet]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hexString: "#1C1C1C")
        tableView.register(PlanetCell.self, forCellReuseIdentifier: PlanetCell.identifier)
        tableView.separatorColor = .clear
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.color = .white
        return view
    }()
    
    private lazy var loadingFailedView: UIView = {
        let view = UIView()
        
        view.addSubview(errorTitleLabel)
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorMessageLabel)
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(retryButton)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            errorTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            errorMessageLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 4),
            errorMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            retryButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 15),
            retryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 100.0),
            retryButton.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        
        return view
    }()
    
    private lazy var errorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Loading Failed"
        return label
    }()
    
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()
    
    private var presentedLessonIndex: Int?
    
    //MARK: --- Overrides ---
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupTableView()
        loadData()
    }
    
    //MARK: --- Setup ---

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingFailedView)
        loadingFailedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loadingFailedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingFailedView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loadingFailedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Planets"

        navigationController?.navigationBar.backgroundColor = tableView.backgroundColor
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = tableView.backgroundColor
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    //MARK: --- Actions ---
        
    @objc private func tryAgain() {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadData()
        }
    }
    
    private func loadData() {
        self.state = .loading
        APIService.shared.loadPlanets { (planets: [Planet]?, error: Error?) in
            if let planets = planets {
                self.planets = planets
                self.tableView.reloadData()
                self.state = .loaded
            } else {
                self.state = .loadingFailed
            }
            self.errorMessageLabel.text = error?.localizedDescription
            
        }
    }
    
    //MARK: --- UITableViewDataSource methods ---
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanetCell.identifier, for: indexPath) as! PlanetCell
        
        planets[indexPath.row].index = indexPath.row
        cell.set(planet: planets[indexPath.row], imageId: indexPath.row)

        return cell
    }
    
    //MARK: --- UITableViewDelegate methods ---
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let planet = planets[indexPath.row]
        let detailVc = PlanetDetailViewController(planet: planet)
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

