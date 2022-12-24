//
//  LoginVC.swift
//  FinalProject
//
//  Created by Ahmed Hinawi on 15/12/2022.
//

import UIKit
import SwiftUI

struct GenericUIViewControllerRepresentable<T: UIViewController>: UIViewControllerRepresentable {
    let create: () -> T
    let update: (T) -> ()
    func makeUIViewController(context: Context) -> T {
        create()
    }

    func updateUIViewController(_ controller: T, context: Context) {
        update(controller)
    }
}

struct LoginVC_Preview: PreviewProvider {
    static var previews: some View {
        GenericUIViewControllerRepresentable {
            LoginVC()
        } update: { _ in
        }
    }
}

class LoginVC: UIViewController {
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()



 

    private let notHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "ليس لديك حساب ؟"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let createAccountBtn: UIButton = {
        let button = UIButton()
        button.setTitle("أنشئ حساب", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("تسجيل الدخول", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let forgetPasswordbtn: UIButton = {
        let button = UIButton()
        button.setTitle("هل نسيت كلمة المرور ؟", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let imageLogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "iTunesArtwork")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        return imageView
    }()

    private let emailtxt: UITextField = {
        let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "البريد الإكتروني", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()

    private let passwordtxt: UITextField = {
        let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "كلمة المرور", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filed.textAlignment = .center
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.isSecureTextEntry = true
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        addConstraints()
        view.backgroundColor = .mainColor
        loginBtn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }

    @objc private func didTapLogin() {
        guard let Email = emailtxt.text, !Email.isEmpty else {
            self.showOkAlert(title: "", message: Auth_Strings.shared.EmailIsRequired())
            return
        }

        guard Email.isEmailValid else {
            self.showOkAlert(title: "", message: Auth_Strings.shared.InvalidEmail())
            return
        }
        guard let Password = passwordtxt.text, !Password.isEmpty else {
            self.showOkAlert(title: "", message: Auth_Strings.shared.PasswordIsRequired())
            return
        }

        DataBaseManager.shared.logIn(WithEmail: Email, Password: Password) { ErrorMessage, userId in
            if let _error = ErrorMessage {
                self.showOkAlert(message: _error)
                return
            }
            if !Auth_Verified.shared.IsEmailVerified() {
                self.showOkAlert(title: "", message: Auth_Strings.shared.PleaseVerifyEmail())
                return
            }
            Constants.users_path.child(userId).observeSingleEvent(of: .value) { snapshot in
                Auth_User.UserData = UserSt(snapshot).toAnyObject()
                Auth_User._Token = userId
                Auth_User._Password = Password
                let main = MainTabBarVC()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(main)
            }
        }
    }
}

extension LoginVC {
    private func createViews() {
        view.addSubview(imageLogo)
        view.addSubview(emailtxt)
        view.addSubview(passwordtxt)
        view.addSubview(loginBtn)
        view.addSubview(forgetPasswordbtn)
        view.addSubview(lineView)
        view.addSubview(notHaveAccountLabel)
        view.addSubview(createAccountBtn)
        createAccountBtn.addTarget(self, action: #selector(didTapRegiset), for: .touchUpInside)
    }

    @objc private func didTapRegiset() {
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        present(UINavigationController(rootViewController: vc), animated: true)
    }

    private func addConstraints() {
        let imageLogoConstraints = [
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageLogo.heightAnchor.constraint(equalToConstant: 150),
            imageLogo.widthAnchor.constraint(equalToConstant: 150),
        ]
        let emailtxtConstraints = [
            emailtxt.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 20),
            emailtxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailtxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emailtxt.heightAnchor.constraint(equalToConstant: 40),
        ]

        let passwordtxtConstrains = [
            passwordtxt.topAnchor.constraint(equalTo: emailtxt.bottomAnchor, constant: 10),
            passwordtxt.leadingAnchor.constraint(equalTo: emailtxt.leadingAnchor),
            passwordtxt.trailingAnchor.constraint(equalTo: emailtxt.trailingAnchor),
            passwordtxt.heightAnchor.constraint(equalToConstant: 40),
        ]

        let loginButtonConstraints = [
            loginBtn.topAnchor.constraint(equalTo: passwordtxt.bottomAnchor, constant: 30),
            loginBtn.centerXAnchor.constraint(equalTo: passwordtxt.centerXAnchor),
            loginBtn.widthAnchor.constraint(equalToConstant: 130),
            loginBtn.heightAnchor.constraint(equalToConstant: 40),
        ]

        let ForgetPasswordButtonConstraints = [
            forgetPasswordbtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 10),
            forgetPasswordbtn.centerXAnchor.constraint(equalTo: passwordtxt.centerXAnchor),
            forgetPasswordbtn.widthAnchor.constraint(equalToConstant: 180),
            forgetPasswordbtn.heightAnchor.constraint(equalToConstant: 40),
        ]

        let lineViewConstraints = [
            lineView.topAnchor.constraint(equalTo: forgetPasswordbtn.bottomAnchor, constant: 10),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]

 

        let nothaveAccountConstraints = [
            notHaveAccountLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            notHaveAccountLabel.heightAnchor.constraint(equalToConstant: 20),
            notHaveAccountLabel.centerXAnchor.constraint(equalTo: lineView.centerXAnchor),
        ]
        

        let createAccountButtonConstraints = [
            createAccountBtn.topAnchor.constraint(equalTo: notHaveAccountLabel.bottomAnchor, constant: 20),
            createAccountBtn.heightAnchor.constraint(equalToConstant: 20),
            createAccountBtn.centerXAnchor.constraint(equalTo: notHaveAccountLabel.centerXAnchor),
        ]
        

        NSLayoutConstraint.activate(imageLogoConstraints)
        NSLayoutConstraint.activate(emailtxtConstraints)
        NSLayoutConstraint.activate(passwordtxtConstrains)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(ForgetPasswordButtonConstraints)
        NSLayoutConstraint.activate(lineViewConstraints)
        NSLayoutConstraint.activate(createAccountButtonConstraints)
        NSLayoutConstraint.activate(nothaveAccountConstraints)
    }
}
