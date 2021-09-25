//
//  LoginViewModel.swift
//  Demo Project
//
//  Created by Ali Rahal on 9/25/21.
//
import RxSwift
import RxCocoa

struct UserRegisterCredentials {
    let email: String
    let password: String
    let age: String
}

class RegisterViewModel: ViewModelProtocol {
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let age: AnyObserver<Int>
        let registerDidTap: AnyObserver<Void>
    }
    struct Output {
        let RegisterResultObservable: Observable<User>
        let errorsObservable: Observable<Error>
        let isValid: Observable<Bool>
    }
    // MARK: - Public properties
    let input: Input
    let output: Output
    
    // MARK: - Private properties
    private let emailSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let ageSubject = PublishSubject<Int>()
    private let registerDidTapSubject = PublishSubject<Void>()
    private let RegisterResultObservableSubject = PublishSubject<User>()
    private let errorsSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    private var isValid = BehaviorSubject<Bool>(value: false)
    
    private var credentialsObservable: Observable<Credentials> {
        return Observable.combineLatest(emailSubject.asObservable(), passwordSubject.asObservable()) { (email, password) in
            return Credentials(email: email, password: password)
        }
    }
    
    // MARK: - Init and deinit
    init() {
        
        input = Input(email: emailSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      age: ageSubject.asObserver(),
                      registerDidTap: registerDidTapSubject.asObserver())
        
        output = Output(RegisterResultObservable: RegisterResultObservableSubject.asObservable(),
                        errorsObservable: errorsSubject.asObservable(),
                        isValid: isValid.asObservable())
        
        
        Observable.combineLatest(emailSubject.asObservable(),passwordSubject.asObservable(),ageSubject.asObservable()){ email,password,age in
            let passwordTextLengthValid = self.validateLength(text: password, size: (6,15))
            let validEmailFormat = self.validatePattern(text: email)
            let validAge = age < 99 && age > 18
            return passwordTextLengthValid && validEmailFormat && validAge
        }.bind(to: isValid).disposed(by: disposeBag)
        
        registerDidTapSubject
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
