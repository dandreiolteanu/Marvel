//
//  BaseViewController.swift
//  Marvel
//
//  Created by Andrei Olteanu on 21.06.2022.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Public Properties

    var isBackButtonHidden: Bool = true {
        didSet {
            navigationItem.leftBarButtonItem = isBackButtonHidden ? nil : backButtonItem
        }
    }

    // MARK: - Private Properties

    private lazy var keyboardDismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    private lazy var backButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "Asset.icnBack.image"), style: .plain, target: self, action: #selector(backButtonPressed))
    }()
    
    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Base Class Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpForKeyboardNotifications()
        setupBackButtonIfNeeded()
        setupView()
        setupConstraints()
        setupBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    // MARK: - Methods which each view controller should override

    func setupView() { }
    func setupConstraints() { }
    func setupBindings() { }

    // MARK: - Public Methods

    func addDismissKeyboardGesture() {
        view.addGestureRecognizer(keyboardDismissTapGesture)
    }

    func removeDismissKeyboardGesture() {
        view.removeGestureRecognizer(keyboardDismissTapGesture)
    }

    // MARK: - Private Methods

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Navigation Bar
    
    private func setupBackButtonIfNeeded() {
        navigationItem.hidesBackButton = true

        guard navigationController?.viewControllers.first !== self else { return }
        navigationItem.leftBarButtonItem = backButtonItem
    }

    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - KeyboardPresenting

    private func signUpForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardPresenter = self as? KeyboardPresenting else { return }
        guard let (frame, duration, animationCurve) = keyboardParameters(userInfo: notification.userInfo) else { return }
        keyboardPresenter.keyboardWillShow(frame: frame, duration: duration, animationCurve: animationCurve)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardPresenter = self as? KeyboardPresenting else { return }
        guard let (frame, duration, animationCurve) = keyboardParameters(userInfo: notification.userInfo) else { return }
        keyboardPresenter.keyboardWillHide(frame: frame, duration: duration, animationCurve: animationCurve)
    }

    private func keyboardParameters(userInfo: [AnyHashable: Any]?) -> (CGRect, TimeInterval, UIView.AnimationCurve)? {
        guard let frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
        guard let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return nil }
        guard let animationCurveRawValue = (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int) else { return nil }
        guard let animationCurve = UIView.AnimationCurve(rawValue: animationCurveRawValue) else { return nil }

        return (frame, duration, animationCurve)
    }
}
