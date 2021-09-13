//
//  HomeTabView.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/10/21.
//

import UIKit

protocol HomeTabViewDelegate {
    func didTapGetJoke(_ view: HomeTabView, jokeResultLabel: UILabel)
    func didTapSaveJoke(_ view: HomeTabView)
}

class HomeTabView: UIView {
    //MARK: - Properties
    var delegate: HomeTabViewDelegate?

    var initialJoke: String? {
        didSet {
            guard let initialJoke = initialJoke else { return }
            jokeResultLabel.text = initialJoke
        }
    }

    private let titleImageView: UIImageView = {
        let tv = UIImageView()
        tv.image = #imageLiteral(resourceName: "Dad Jokes2")
        tv.clipsToBounds = true
        tv.layer.cornerRadius = 40
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor.black.cgColor
        return tv
    }()

    private let jokeResultViewContainer: UILabel = {
        let jc = UILabel()
        jc.layer.cornerRadius = 15
        jc.layer.borderWidth = 2
        jc.layer.borderColor = UIColor.black.cgColor
        jc.layer.masksToBounds = true
        jc.backgroundColor = .lightGold
        return jc
    }()

    private let jokeResultLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Chalkboard SE", size: 24)
        lb.numberOfLines = 0
        lb.textColor = .black
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        return lb
    }()

    private let saveJokeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(didTapSaveJokeButton), for: .touchUpInside)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        return btn
    }()

    private let getJokeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 24)
        btn.titleLabel?.tintColor = .black
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 40
        btn.addTarget(self, action: #selector(didTapGetjokeButton), for: .touchUpInside)
        btn.backgroundColor = .mainGold
        return btn
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    func configureMainUI() {
        backgroundColor = .mainGold
        addAllSubviews()
        addAllConstraints()
    }

    private func addAllSubviews() {
        let subviews = [titleImageView, jokeResultViewContainer, jokeResultLabel, saveJokeButton, getJokeButton]

        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func addAllConstraints() {
        let layout = layoutMarginsGuide

        let constraints = [
            titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: layout.topAnchor, constant: 20),
            titleImageView.heightAnchor.constraint(equalToConstant: 80),
            titleImageView.widthAnchor.constraint(equalToConstant: 80),

            jokeResultViewContainer.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 20),
            jokeResultViewContainer.bottomAnchor.constraint(equalTo: getJokeButton.topAnchor, constant: -20),
            jokeResultViewContainer.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            jokeResultViewContainer.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),

            jokeResultLabel.centerYAnchor.constraint(equalTo: jokeResultViewContainer.centerYAnchor),
            jokeResultLabel.leftAnchor.constraint(equalTo: jokeResultViewContainer.leftAnchor, constant: 30),
            jokeResultLabel.rightAnchor.constraint(equalTo: jokeResultViewContainer.rightAnchor, constant: -30),
            jokeResultLabel.topAnchor.constraint(equalTo: jokeResultViewContainer.topAnchor, constant: 30),
            jokeResultLabel.bottomAnchor.constraint(equalTo: jokeResultViewContainer.bottomAnchor, constant: -30),

            saveJokeButton.bottomAnchor.constraint(equalTo: jokeResultViewContainer.bottomAnchor, constant: -10),
            saveJokeButton.rightAnchor.constraint(equalTo: jokeResultViewContainer.rightAnchor, constant: -10),
            saveJokeButton.heightAnchor.constraint(equalToConstant: 30),
            saveJokeButton.widthAnchor.constraint(equalToConstant: 35),

            getJokeButton.heightAnchor.constraint(equalToConstant: 80),
            getJokeButton.widthAnchor.constraint(equalToConstant: 80),
            getJokeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            getJokeButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20),
            getJokeButton.topAnchor.constraint(greaterThanOrEqualTo: jokeResultViewContainer.bottomAnchor, constant: 10)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

private extension HomeTabView {
    @objc func didTapGetjokeButton() {
        self.delegate?.didTapGetJoke(self, jokeResultLabel: jokeResultLabel)
    }

    @objc func didTapSaveJokeButton() {
        self.delegate?.didTapSaveJoke(self)
    }
}
