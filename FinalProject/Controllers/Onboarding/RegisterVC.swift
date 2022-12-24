//
//  RegisterVC.swift
//  FinalProject
//
//  Created by Ahmed Hinawi on 15/12/2022.
//

import UIKit
import FirebaseAuth
import SwiftUI

struct RegisterVC_Preview: PreviewProvider {
    static var previews: some View {
        GenericUIViewControllerRepresentable {
            RegisterVC()
        } update: { _ in
        }
    }
}

class RegisterVC: UIViewController {
    var delegate: ((String) -> ())?
    
    private let registerbtn: UIButton = {
        let button = UIButton()
        button.setTitle("تسجيل", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let _switch: UISwitch = {
        let _switch = UISwitch()
        _switch.translatesAutoresizingMaskIntoConstraints = false
        _switch.isOn = true
        return _switch
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "الموافقة على الشروط والأحكام"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "user1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }()
    
    private let userNametxt: UITextField = {
        let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "اسم المتسخدم ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let emailtxt: UITextField = {
        let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "البريد الإكتروني", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let phoneNumbertxt: UITextField = {
        let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "رقم الموبايل", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let passwordtxt: UITextField = {
        let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "كلمة المرور", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.isSecureTextEntry = true
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let confirmpasswordtxt: UITextField = {
        let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "تأكيد كلمة المرور", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.isSecureTextEntry = true
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor
        registerbtn.addTarget(self, action: #selector(didTapRegiset), for: .touchUpInside)
        setupUI()
    }
    
    func setupUI() {
        let buttonBg = UIView()
        self.view.addSubview(buttonBg)
        defer {
          
            buttonBg.translatesAutoresizingMaskIntoConstraints = false
            
            buttonBg.layer.borderColor = UIColor.white.cgColor
            buttonBg.layer.borderWidth = 2
            buttonBg.layer.cornerRadius = 5


            buttonBg.centerXAnchor.constraint(equalTo: registerbtn.centerXAnchor).isActive = true
            buttonBg.centerYAnchor.constraint(equalTo: registerbtn.centerYAnchor).isActive = true
            
            buttonBg.widthAnchor.constraint(equalToConstant: 150).isActive = true
            buttonBg.heightAnchor.constraint(equalTo: registerbtn.heightAnchor,constant: 5).isActive = true

            
        }
      
        let switchStack = UIStackView(
            arrangedSubviews: [
                _switch,
                label,
            ]
        )
        
        imageLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(imageLogo)
        
        imageLogo.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        imageLogo.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        imageLogo.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        
        
        switchStack.spacing = 8
        
        let stack = UIStackView(arrangedSubviews: [
            container,
            userNametxt,
            emailtxt,
            passwordtxt,
            confirmpasswordtxt,
            phoneNumbertxt,
            switchStack,
            registerbtn,
            
        ])
        
        stack.arrangedSubviews.forEach {
            $0.semanticContentAttribute = .forceRightToLeft
            ($0 as? UITextField)?.textAlignment = .right
            ($0 as? UILabel)?.textAlignment = .right
        }
        
        [
            userNametxt,
            emailtxt,
            passwordtxt,
            confirmpasswordtxt,
            phoneNumbertxt,
        ]
            .forEach {
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            }
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .vertical
        self.view.addSubview(stack)
        
        stack.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -40).isActive = true
        
        
    }
    
    @objc private func didTapRegiset() {
        guard let Name = userNametxt.text, !Name.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.NameRequired))
            return
        }
        
        guard let Email = emailtxt.text, !Email.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.EmailRequired))
            return
        }
        
        guard let PhoneNumber = phoneNumbertxt.text, !PhoneNumber.TrimWhiteSpaces.isEmpty, PhoneNumber.isValidPhone else {
            self.showToast(Auth_Strings.Message(.PhotoRequired))
            return
        }
        
        guard Email.isEmailValid else {
            self.showToast(Auth_Strings.Message(.InvalidEmail))
            return
        }
        
        guard let Password = passwordtxt.text, !Password.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.PasswordRequired))
            return
        }
        
        guard let ConfirmPassword = confirmpasswordtxt.text, !ConfirmPassword.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.ConfirmPasswordRequired))
            return
        }
        
        guard Password == ConfirmPassword else {
            self.showToast(Auth_Strings.Message(.PasswordAndConfirmationNotMatch))
            return
        }
        guard _switch.isOn == true else {
            self.showToast("الرجاء الموافقة على الشروط والأحكام")
            return
        }
        
        DataBaseManager.shared.register(email: Email, password: Password) { userid in
            Auth_Verified.shared.sendVerificationMail(completion: { ErrorMessage in
                
                let user_obj = UserSt(
                    UserId: userid,
                    Username: Name,
                    Location: PhoneNumber,
                    Email: Email,
                    UserImage: "",
                    Gender: ""
                )
                
                Auth_User._Token = user_obj.UserId
                Constants.users_path.child(userid).updateChildValues(user_obj.toDic()) { error, data in
                    if error != nil {
                        self.showOkAlert(message: error!.localizedDescription)
                    } else {
                        self.showOkAlertWithComp(title: "", message: Auth_Strings.Message(.CreateAccountSuccessfully)) { action in
                            let main = LoginVC()
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(main)
                        }
                    }
                }
            })
        }
    }
}

extension UIView {
    func with(_ action: (Self) -> ()) -> Self {
        action(self)
        return self
    }

    func useAutoLayout() -> Self {
        with {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
