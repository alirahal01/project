//
//  LoginViewModel.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//
import RxSwift
import RxCocoa

struct Credentials {
    let email: String
    let password: String
}

struct User: Codable {
    
}

/// Base for all controller viewModels.
///
/// It contains Input and Output types, usually expressed as nested structs inside a class implementation.
///
/// Input type should contain observers (e.g. AnyObserver) that should be subscribed to UI elements that emit input events.
///
/// Output type should contain observables that emit events related to result of processing of inputs.
protocol ViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
}

class LoginViewModel: ViewModelProtocol {
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let signInDidTap: AnyObserver<Void>
    }
    struct Output {
        let RegisterResultObservable: Observable<User>
        let errorsObservable: Observable<Error>
        let isValid: Observable<Bool>
        let goToRegister: Observable<Void>
        
    }
    // MARK: - Public properties
    let input: Input
    let output: Output
    
    // MARK: - Private properties
    private let emailSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let RegisterResultSubject = PublishSubject<User>()
    private let errorsSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    private var isValid = BehaviorSubject<Bool>(value: false)
    private let goToRegisterVC = PublishSubject<Void>()
    
    private var credentialsObservable: Observable<Credentials> {
        return Observable.combineLatest(emailSubject.asObservable(), passwordSubject.asObservable()) { (email, password) in
            return Credentials(email: email, password: password)
        }
    }
    
    // MARK: - Init and deinit
    init() {
        
        input = Input(email: emailSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      signInDidTap: signInDidTapSubject.asObserver())
        
        output = Output(RegisterResultObservable: RegisterResultSubject.asObservable(),
                        errorsObservable: errorsSubject.asObservable(), isValid: isValid.asObservable(), goToRegister: goToRegisterVC.asObservable())
        
        
        Observable.combineLatest(emailSubject.asObservable(),passwordSubject.asObservable()){ email,password in
            let passwordTextLengthValid = self.validateLength(text: password, size: (6,15))
            let validEmailFormat = self.validatePattern(text: email)
            return passwordTextLengthValid && validEmailFormat
        }.bind(to: isValid).disposed(by: disposeBag)
        
        signInDidTapSubject
            .withLatestFrom(credentialsObservable)
            .subscribe(onNext: { e in
                print(e)
            })
            .disposed(by: disposeBag)
        
    }
    //add to extension of string
    func validatePattern(text : String) -> Bool{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: text)
        }
    
        
        func validateLength(text : String, size : (min : Int, max : Int)) -> Bool{
            return (size.min...size.max).contains(text.count)
        }
    
    deinit {
        print("\(self) dealloc")
    }
}
