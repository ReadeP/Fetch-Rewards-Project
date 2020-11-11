//
//  ItemTableViewCell.swift
//  Fetch-Rewards-Project
//
//  Created by Reade Plunkett on 11/10/20.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none

        nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        nameLabel.textColor = .systemGray3
        contentView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: Item) {
        guard let name = item.name else {
            return
        }

        nameLabel.text = name
    }

}
