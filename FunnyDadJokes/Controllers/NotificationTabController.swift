//
//  NotificationTabController.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/12/21.
//

import UIKit

class NotificationTabController: UIViewController {
    //MARK: - Properties
    private let notificationTabView = NotificationTabView()

    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = notificationTabView
        notificationTabView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helper
    func configureUI() {
        title = "Notification"
        view.backgroundColor = .mainGold
    }

    //MARK: - Actions
    func setNotificationAlertMessage(hour: Int, minute: Int) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Daily Joke Notification", message: "You have set to get daily joke notification at \(hour):\(minute)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            self.present(ac, animated: true)
        }
        HapticFeedback.success()
    }

    func register(completion: @escaping(Bool) -> Void) {
        NotificationHelper.requestForPermission { [weak self] granted in
            if !granted {
                DispatchQueue.main.async {
                    let title = "Daily joke notification is disabled. If you want to enable it. You can go to Settings, and then Notifications"
                    let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .default))
                    self?.present(ac, animated: true)
                    HapticFeedback.selectionChanged()
                    completion(false)
                    return
                }
            } else {
                completion(true)
            }
        }
    }

}

//MARK: - NotificationTabView Delegate
extension NotificationTabController: NotificationTabViewDelegate {
    func setNotification(hour: Int, minute: Int) {
        register { success in
            if !success { return }

            var jokeBody = ""
            JokeAPI.shared.fetchJoke { data in
                if let data = data {
                    jokeBody = data.joke
                } else {
                    jokeBody = "What concert costs only 45 cents? 50 cent featuring Nickelback"
                }
                NotificationHelper.scheduleLocalNotification(hour: hour, minute: minute, body: jokeBody)
                self.setNotificationAlertMessage(hour: hour, minute: minute)
            }
        }
    }
}
