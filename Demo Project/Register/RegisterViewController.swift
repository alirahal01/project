//
//  RegisterViewController.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//

import Foundation
import RxSwift
import UIKit

class RegisterViewController: UIViewController, ControllerType {
    
    typealias ViewModelType = RegisterViewModel
    // MARK: - Properties
    public var viewModel: ViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = RegisterViewModel()
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
        
        ageTextfield.rx.text.orEmpty
            .map { Int($0) ?? 0 }
            .asObservable()
            .subscribe(viewModel.input.age)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap.asObservable()
            .subscribe(viewModel.input.registerDidTap)
            .disposed(by: disposeBag)
        
        viewModel.output.isValid.bind(to: self.registerButton.rx.isEnabled).disposed(by: disposeBag)
        
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

    }
}

