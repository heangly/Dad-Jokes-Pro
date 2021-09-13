//
//  FavoriteTabCell.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/11/21.
//

import UIKit

class FavoriteTabCell: UITableViewCell {
    //MARK: - Properties
    static let reusableID = "FavoriteTabCell"

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    func configureCell() {
        textLabel?.numberOfLines = 0
        textLabel?.font = UIFont(name: "Chalkboard SE", size: 20)
        textLabel?.textColor = .black
        selectionStyle = .none
        backgroundColor = .lightGold
        layer.borderColor = UIColor.mainGold.cgColor
        layer.borderWidth = 2
    }
}
