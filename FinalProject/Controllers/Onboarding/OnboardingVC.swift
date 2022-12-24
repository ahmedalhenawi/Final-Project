//
//  OnboardingVC.swift
//  FinalProject
//
//  Created by Ahmed Hinawi on 15/12/2022.
//

import UIKit

import SwiftUI

struct OnboardingVC_Preview: PreviewProvider {
    static var previews: some View {
        GenericUIViewControllerRepresentable {
            OnboardingVC()
        } update: { _ in
        }
    }
}
class OnboardingVC: UIViewController {
    
    
    private let loginAdmin  = EButton(backgroundColor: .white , title: "شركة - تم الغاؤها", TextStyle: .subheadline)
    private let loginUser = EButton(backgroundColor: .white , title: "مستخدم", TextStyle: .subheadline)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .mainColor
        loginAdmin.setTitleColor(.mainColor, for: .normal)
        loginUser.setTitleColor(.mainColor, for: .normal)
        loginUser.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        setupUI()

    }
    
    @objc private func loginTapped(){
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    private func setupUI() {
    
        
        let stack = UIStackView(arrangedSubviews: [loginAdmin,loginUser])
        stack.axis = .vertical
        stack.spacing = 20
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -160).isActive = true
        



        
    }

}

extension UIColor {
    static var mainColor: UIColor? {
        UIColor(named: "MAIN")
    }
}
