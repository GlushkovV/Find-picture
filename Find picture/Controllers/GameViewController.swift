//
//  GameViewController.swift
//  Find picture
//
//  Created by Vitaly Glushkov on 23.10.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    var selectedImage: String?
    var selectCellOne: Bool = false
    var selectCellTwo: Bool = false

    var selectOne: Bool = false
    var selectTwo: Bool = false
    var selectThree: Bool = false
    
    var selectedIndexPathOne, selectedIndexPathTwo: IndexPath?
    var selectedImageCellOne, selectedImageCellTwo: UIImage?
    
    var selectIndexOne, selectIndexTwo: IndexPath?
    
    private enum Constants {
        static let itemCount: CGFloat = 4
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    } ()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.delegate = self
        view.dataSource = self
        view.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var gameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать игру", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.gameButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private var dataSource:[String] = ["1.jpeg",
                                       "2.jpeg",
                                       "3.jpeg",
                                       "4.jpeg",
                                       "5.jpeg",
                                       "6.jpeg",
                                       "7.jpeg",
                                       "8.jpeg"]
    private var tempDataSource: [String] = []
    private var collectionDataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        initCollectionDataSource()
    }
    
    func setupView() {
        view.backgroundColor = .white
        collectionView.isUserInteractionEnabled = false
        view.addSubview(collectionView)
        view.addSubview(gameButton)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
            
            gameButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -20),
            gameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            gameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            gameButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        )
    }
    
    func initCollectionDataSource() {
        for _ in 0...(Int(Constants.itemCount) * 2) - 1 {
            let tempIndex = Int.random(in: 0...dataSource.count - 1)
            self.tempDataSource.append(dataSource[tempIndex])
            self.tempDataSource.append(dataSource[tempIndex])
            dataSource.remove(at: tempIndex)
        }
        for _ in 0...tempDataSource.count - 1 {
            let tempIndex = Int.random(in: 0...tempDataSource.count - 1)
            self.collectionDataSource.append(tempDataSource[tempIndex])
            tempDataSource.remove(at: tempIndex)
        }
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - (Constants.itemCount + 1) * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    @objc func gameButtonClicked () {
        collectionView.isUserInteractionEnabled = true
        for i in collectionView.indexPathsForVisibleItems {
            collectionView.cellForItem(at: i)?.contentView.isHidden = true
        }
        gameButton.isHidden = true
    }
    
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Constants.itemCount * Constants.itemCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
            cell.backgroundColor = .black
            return cell
        }
        cell.backgroundColor = .systemGray6
        cell.pictureImages.image = UIImage(named: collectionDataSource[indexPath.row])
        if (selectCellOne && indexPath == selectedIndexPathOne) || (selectCellTwo && indexPath == selectedIndexPathTwo) {
            cell.pictureImages.alpha = 1
        }
        if selectedIndexPathOne != nil && selectedIndexPathOne == indexPath {
            selectedImageCellOne = cell.pictureImages.image
        }
        if selectedIndexPathTwo != nil && selectedIndexPathTwo == indexPath {
            selectedImageCellTwo = cell.pictureImages.image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectCellOne == false {
            selectCellOne = true
            selectedIndexPathOne = indexPath
            collectionView.reloadItems(at: [indexPath])
            collectionView.cellForItem(at: indexPath)?.contentView.isHidden = false
        } else if selectCellTwo == false {
            selectCellTwo = true
            selectedIndexPathTwo = indexPath
            collectionView.reloadItems(at: [indexPath])
            collectionView.cellForItem(at: indexPath)?.contentView.isHidden = false
        }
        if selectOne == false {
            selectOne = true
            selectIndexOne = indexPath
        } else if selectTwo == false {
            selectTwo = true
            selectIndexTwo = indexPath
        } else if selectThree == false {
            selectThree = true
        }
        if selectedIndexPathOne != nil && selectedIndexPathTwo != nil && selectedImageCellOne != nil && selectedImageCellTwo != nil && selectedImageCellOne == selectedImageCellTwo && selectedIndexPathOne != selectedIndexPathTwo {
            collectionView.cellForItem(at: selectedIndexPathOne!)?.isHidden = true
            collectionView.cellForItem(at: selectedIndexPathTwo!)?.isHidden = true
            selectedIndexPathOne = nil
            selectedIndexPathTwo = nil
            selectCellOne = false
            selectCellTwo = false
        } else if selectedIndexPathOne != nil && selectedIndexPathTwo != nil && selectedImageCellOne != nil && selectedImageCellTwo != nil && selectedImageCellOne != selectedImageCellTwo {
            selectedIndexPathOne = nil
            selectedIndexPathTwo = nil
            selectCellOne = false
            selectCellTwo = false
            selectedImageCellOne = nil
            selectedImageCellTwo = nil
        } else if selectedIndexPathOne != nil && selectedIndexPathTwo != nil && selectedIndexPathOne == selectedIndexPathTwo {
            selectedIndexPathOne = nil
            selectedIndexPathTwo = nil
            selectCellOne = false
            selectCellTwo = false
            selectedImageCellOne = nil
            selectedImageCellTwo = nil
        }
        if selectOne == true && selectTwo == true && selectThree == true {
            collectionView.cellForItem(at: selectIndexOne!)?.contentView.isHidden = true
            collectionView.cellForItem(at: selectIndexTwo!)?.contentView.isHidden = true
            selectOne = true
            selectTwo = false
            selectThree = false
            selectCellOne = true
            selectedIndexPathOne = indexPath
            selectIndexOne = indexPath
            selectIndexTwo = nil
        }
    }
    
}
