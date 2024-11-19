//
//  SignUpController.swift
//  BankingApp
//
//  Created by Kenan on 02.11.24.
//

import UIKit
import RealmSwift
class SignUpController: UIViewController {
    var callback: ((String, Int) -> Void)?
    
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    lazy var createLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var FinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "FIN"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "e-mail"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        return textField
    }()
    
    
    
    lazy var signupButton: ReusableButton = {
        let button = ReusableButton(title: "SignUP", onaction: {[ weak self ] in self?.signupTapped()})
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTextFields()
        
    }
    
    @objc func signupTapped() {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let passwordText = passwordTextField.text,
              let fin = FinTextField.text,
              let password = Int(passwordText) else {
            
            showAlert(title: "error", message: "True fields are required")
            return
           
            
                    }
        let user = User()
        user.name = name
        user.email = email
        user.password = password
        user.fin = fin
        SignUpViewModel().fetchdata(user: user)
        
        let viewModel = SignUpViewModel()
        if let errorMessage = viewModel.validateFields(name: name, email: email, password: passwordText, fin: fin) {
        }
        
                callback?(name , password)
                navigationController?.popViewController(animated: true)
        
         
             
        
        }
        
    

    
    
    
        
    private func configureTextFields() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        FinTextField.delegate = self
    }
    
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(createLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(FinTextField)
        stackView.addArrangedSubview(signupButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            FinTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        
        
    }
}


extension SignUpController:  UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            if let email = emailTextField.text {
                if email.isEmpty {
                    emailTextField.layer.borderColor = UIColor.red.cgColor
                    emailTextField.layer.borderWidth = 1
                }
                
            }
            
        }
        
        if textField == passwordTextField {
            if let password = passwordTextField.text {
                if password.isEmpty {
                    passwordTextField.layer.borderColor = UIColor.red.cgColor
                    passwordTextField.layer.borderWidth = 1
                    
                }
                
                
            }
        }
        if textField == nameTextField {
            if let name = nameTextField.text {
                if name.isEmpty {
                    nameTextField.layer.borderColor = UIColor.red.cgColor
                    nameTextField.layer.borderWidth = 1
                    
                    
                }
            }
        }
        if textField == FinTextField {
            if let Fin = FinTextField.text {
                if Fin.isEmpty {
                    FinTextField.layer.borderColor = UIColor.red.cgColor
                    FinTextField.layer.borderWidth = 1
                    
                    
                    
                }
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == emailTextField {
            if let email = emailTextField.text {
                if email.isValidEmail(email) {
                    textField.layer.borderColor = UIColor.green.cgColor
                    textField.layer.borderWidth = 1
                } else {
                    textField.layer.borderColor = UIColor.red.cgColor
                    textField.layer.borderWidth = 1
                    
                }
            }
        }
        if textField == passwordTextField {
            if let password = passwordTextField.text {
                if password.count >= 8 {
                    textField.layer.borderColor = UIColor.green.cgColor
                    textField.layer.borderWidth = 1
                } else {
                    textField.layer.borderColor = UIColor.red.cgColor
                    textField.layer.borderWidth = 1
                    
                }
            }
            
        }
        if textField == nameTextField {
            if let name = nameTextField.text {
                if name.prefix(1) != name.prefix(1).uppercased() {
                    textField.layer.borderColor = UIColor.red.cgColor
                    textField.layer.borderWidth = 1
                    
                } else {
                    textField.layer.borderColor = UIColor.green.cgColor
                    textField.layer.borderWidth = 1
                    
                }
            }
        }
        if  FinTextField.text? .count == 7 {
            FinTextField.layer.borderColor = UIColor.green.cgColor
            FinTextField.layer.borderWidth = 1
            
        } else {
            //textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1
            
        }
    }
}
















