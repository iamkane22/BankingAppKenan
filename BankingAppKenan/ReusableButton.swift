//
//  ReusableButton.swift
//  BankingApp
//
//  Created by Kenan on 15.11.24.
//
import UIKit

class ReusableButton: UIButton {
    private var title: String?
    private var onaction: () -> Void?
    
    init(title: String? = nil, onaction: @escaping () -> Void?) {
        self.title = title
        self.onaction = onaction
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        setTitle(title, for: .normal)
        addTarget( self, action: #selector(signupTapped), for: .touchUpInside)
        backgroundColor = .blue
        layer.cornerRadius = 20
    }
    
    func setupLoginButton() {
        setTitle(title, for: .normal)
        addTarget( self, action: #selector(loginTapped), for: .touchUpInside)
        backgroundColor = .blue
        layer.cornerRadius = 20
    }
    
    @objc func signupTapped() {
        onaction()
    }
    @objc func loginTapped() {
        onaction()
    }
    
}
