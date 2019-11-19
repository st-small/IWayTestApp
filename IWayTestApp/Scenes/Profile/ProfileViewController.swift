//
//  ProfileViewController.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol ProfileDisplayLogic: class { }

public class ProfileViewController: UIViewController, ProfileDisplayLogic {
    
    // MARK: - UI elements
    private var logoutButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Logout", for: .normal)
        return button
    }()
    
    public var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    private var interactor: ProfileBusinessLogic?
    
    
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
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
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
        
        navigationItem.title = "Profile settings"
        prepareLogoutButton()
    }
    
    private func prepareLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        logoutButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Main logic
    @objc
    private func logoutTapped() {
        showLogoutConfiramationAlert()
    }
    
    private func showLogoutConfiramationAlert() {
        let ac = UIAlertController(title: "Warning!", message: "Do you really want to logout?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.interactor?.makeRequest(request: .logout)
            self.router?.routeAuthorization()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(ac, animated: true, completion: nil)
    }
}
