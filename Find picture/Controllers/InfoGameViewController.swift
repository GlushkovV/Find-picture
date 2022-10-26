//
//  InfoGameViewController.swift
//  Find picture
//
//  Created by Vitaly Glushkov on 23.10.2022.
//

import UIKit

class InfoGameViewController: UIViewController {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Найдите одинаковые пары картинок."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(infoLabel)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

}
