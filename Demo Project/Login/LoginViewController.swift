//
//  LoginViewController.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol ControllerType: AnyObject {
    associatedtype ViewModelType: ViewModelProtocol
    func setupListners()
}

class LoginViewController: UIViewController, ControllerType {
    
    typealias ViewModelType = LoginViewModel
    // MARK: - Properties
    public var viewModel: ViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var goToHomePage: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginViewModel()
        setupListners()
    }
    
    // MARK: - Functions
    func setupListners() {
        emailTextfield.rx.text.orEmpty.asObservable()
            .subscribe(viewModel.input.email)
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text.orEmpty.asObservable()
            .subscribe(viewModel.input.password)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap.subscribe { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }.disposed(by: disposeBag)
        
        goToHomePage.rx.tap.subscribe { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "homePageVC") as! HomePageViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }.disposed(by: disposeBag)
        
        viewModel.output.isValid.bind(to: self.signInButton.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.output.isValid
            .subscribe(onNext: { (isValid) in
                if isValid {
                    //add struct valid that has error message descriptive
                    print("valid conditions")
                } else {
                    print("Invalid conditions")
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.output.errorsObservable
            .subscribe(onNext: { [weak self] (error) in
                print(error)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.RegisterResultObservable
            .subscribe(onNext: { [weak self] (user) in
                print(user)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.goToRegister
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
            })
            .disposed(by: disposeBag)

    }
}
