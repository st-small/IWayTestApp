//
//  AuthorizationViewController.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import SnapKit
import UIKit

public protocol AuthorizationDisplayLogic: class {
    func displayData(viewModel: Authorization.Model.ViewModel)
}

public class AuthorizationViewController: UIViewController, AuthorizationDisplayLogic {
    
    // MARK: - UI elements
    private var loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter login..."
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.borderStyle = .roundedRect
        return field
    }()
    
    private var passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter password..."
        field.isSecureTextEntry = true
        field.textAlignment = .center
        field.autocorrectionType = .no
        field.borderStyle = .roundedRect
        return field
    }()
    
    private var actionButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    // MARK: - Data
    public var router: (NSObjectProtocol & AuthorizationRoutingLogic & AuthorizationDataPassing)?
    private var interactor: AuthorizationBusinessLogic?
    
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
        let interactor = AuthorizationInteractor()
        let presenter = AuthorizationPresenter()
        let router = AuthorizationRouter()
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
        
        view.addSubview(loginField)
        loginField.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(44)
        }
        
        view.addSubview(passwordField)
        passwordField.snp.remakeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(loginField)
            make.height.equalTo(44)
        }
        
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        actionButton.snp.remakeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Main logic
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func loginTapped() {
        spinner.show("Try to login...")
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""
        interactor?.makeRequest(.login(login, password))
    }
    
    private func showErrorAlert(_ message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    private func authorizedSuccess() {
        router?.routeMain()
    }
    
    public func displayData(viewModel: Authorization.Model.ViewModel) {
        switch viewModel {
        case .emptyField(let type):
            switch type {
            case .login:
                showErrorAlert("Login field cannot be empty")
            case .password:
                showErrorAlert("Password field cannot be empty")
            }
        case .fail(let error):
            showErrorAlert(error)
        case .success:
            authorizedSuccess()
        }
        
        spinner.dismiss()
    }
}
