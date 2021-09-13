//
//  NotificationTabView.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/12/21.
//

import UIKit

protocol NotificationTabViewDelegate {
    func setNotification(hour: Int, minute: Int)
}

class NotificationTabView: UIView {
    //MARK: - Properties
    var delegate: NotificationTabViewDelegate?

    private let label: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Chalkboard SE", size: 20)
        lb.textColor = .black
        lb.text = "Choose time for daily notification"
        return lb
    }()

    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.timeZone = NSTimeZone.local
        dp.datePickerMode = .time
        dp.layer.borderWidth = 2
        dp.layer.borderColor = UIColor.black.cgColor
        dp.layer.cornerRadius = 15
        dp.clipsToBounds = true
        dp.setValue(UIColor.black, forKey: "textColor")
        dp.setValue(UIColor.lightGold, forKey: "backgroundColor")
        
        if #available(iOS 13.4, *) {
            dp.preferredDatePickerStyle = .wheels
            dp.setValue(UIColor.lightGold, forKey: "backgroundColor")
        }
        // Fallback on earlier versions


        return dp
    }()

    private let setNotificationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Set", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 24)
        btn.titleLabel?.tintColor = .black
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 40
        btn.addTarget(self, action: #selector(didTapSetNotification), for: .touchUpInside)
        btn.backgroundColor = .mainGold
        return btn
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions
    @objc func didTapSetNotification() {
        let calendar = Calendar.current
        let selectedHour = calendar.component(.hour, from: datePicker.date)
        let selectedMinute = calendar.component(.minute, from: datePicker.date)
        delegate?.setNotification(hour: selectedHour, minute: selectedMinute)
    }

    //MARK: - Helpers
    func configureUI() {
        addAllSubViews()
        addAllConstraints()
    }

    func addAllSubViews() {
        let subviews = [label, datePicker, setNotificationButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func addAllConstraints() {
        let constraints = [
            label.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -30),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),

            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor),

            setNotificationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            setNotificationButton.topAnchor.constraint(greaterThanOrEqualTo: datePicker.bottomAnchor, constant: 30),
            setNotificationButton.heightAnchor.constraint(equalToConstant: 80),
            setNotificationButton.widthAnchor.constraint(equalToConstant: 80),
        ]
        NSLayoutConstraint.activate(constraints)
    }


}
