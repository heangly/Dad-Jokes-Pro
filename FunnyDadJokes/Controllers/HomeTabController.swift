//
//  HomeTabController.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/10/21.
//

import UIKit


class HomeTabController: UIViewController, HomeTabViewDelegate {
    //MARK: - Properties
    private let homeTabView = HomeTabView()

    private var currentJoke: Joke?


    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = homeTabView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTabView.delegate = self
        configureMainUI()
        initializeFirstJoke()
    }


    //MARK: - Helpers
    func configureMainUI() {
        title = "Home"
    }

    func initializeFirstJoke() {
        JokeAPI.shared.fetchJoke { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.homeTabView.initialJoke = data.joke
                self.currentJoke = data
            }
        }
    }

    func alertResult(success: Bool) {
        let title = success ? "Success" : "Duplication"
        let message = success ? "Joke is saved successfully" : "Joke is already saved!"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
    }
}

//MARK: - HomeTabViewDelegate
extension HomeTabController {
    func didTapGetJoke(_ view: HomeTabView, jokeResultLabel: UILabel) {

        JokeAPI.shared.fetchJoke { data in
            guard let data = data else { return }

            DispatchQueue.main.async {
                self.currentJoke = data
                jokeResultLabel.text = self.currentJoke?.joke
            }

        }
    }

    func didTapSaveJoke(_ view: HomeTabView) {
        let ac = UIAlertController(title: "Save This Joke?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let currentJoke = self?.currentJoke else { return }
            CoreDataCRUDHelper.saveJoke(id: currentJoke.id, joke: currentJoke.joke) { [weak self] success in
                self?.alertResult(success: success)
            }
        }))
        present(ac, animated: true)
    }
}

