//
//  MainViewController.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol MainDisplayLogic: class {
    func displayData(_ viewModel: Main.Model.ViewModel)
}

public class MainViewController: UIViewController, MainDisplayLogic {
    
    // MARK: - UI elements
    private var shareButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Share position", for: .normal)
        return button
    }()
    
    private var tableView = PointsTableView()
    
    // MARK: - Data
    public var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    private var interactor: MainBusinessLogic?
    
    // MARK: - Services
    private var spinner: ActivityIndicator = ApplicationDependency.container.resolve()
    
    // MARK: - Object lifecycle
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        userInterfaceSetup()
    }
    
    private func userInterfaceSetup() {
        view.backgroundColor = .white
        
        navigationItem.title = "Share coordinates"
        prepareShareCoordinatesButton()
        prepareTableView()
    }
    
    private func prepareShareCoordinatesButton() {
        view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(sharePositionTapped), for: .touchUpInside)
        shareButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(shareButton.snp.top).offset(-50)
        }
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Main logic
    @objc
    private func sharePositionTapped() {
        spinner.show("Try to share coordinates...")
        interactor?.makeRequest(.sharePosition)
    }
    
    public func displayData(_ viewModel: Main.Model.ViewModel) {
        switch viewModel {
        case .pointShared(let models):
            guard !models.isEmpty else { return }
            tableView.set(models)
        case .fail(let error):
            showErrorAlert(error)
        }
        
        spinner.dismiss()
    }
    
    private func showSucces(_ model: MainModelResponse) {
        let message = """
        You have shared:
        city: \(model.cityName)
        latitude: \(model.coordinates.lat)
        longitude: \(model.coordinates.lon)
        date: \(model.date)
        """
        let ac = UIAlertController(title: "Point shared successfully!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    private func showErrorAlert(_ message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}
