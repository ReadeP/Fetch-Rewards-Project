//
//  ItemTableViewHeader.swift
//  Fetch-Rewards-Project
//
//  Created by Reade Plunkett on 11/10/20.
//

import UIKit

class ItemTableViewHeader: UITableViewHeaderFooterView {

    private let headerLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray

        headerLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        headerLabel.textColor = .black
        contentView.addSubview(headerLabel)

        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(section: TableViewSection) {
        headerLabel.text = "List \(section.id) (\(section.items.count) items)"
    }

}
