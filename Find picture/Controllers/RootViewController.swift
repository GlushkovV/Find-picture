//
//  RootViewController.swift
//  Find picture
//
//  Created by Vitaly Glushkov on 23.10.2022.
//

import UIKit

final class RootViewController: UIViewController {
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Новая игра", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.newGameButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var infoGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Инфо", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.infoGameButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraint()
    }
    
    private func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    func setupView() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newGameButton)
        view.addSubview(infoGameButton)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            newGameButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            newGameButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            newGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newGameButton.heightAnchor.constraint(equalToConstant: 50),
            
            infoGameButton.topAnchor.constraint(equalTo: newGameButton.bottomAnchor, constant: 10),
            infoGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoGameButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        )
    }
    
    @objc func newGameButtonClicked () {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @objc func infoGameButtonClicked () {
        navigationController?.pushViewController(InfoGameViewController(), animated: true)
    }

}
