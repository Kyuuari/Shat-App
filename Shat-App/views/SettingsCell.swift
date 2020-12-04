//
//  SettingsCell.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-12-03.
//

import Foundation
import UIKit

class SettingsCell: UITableViewCell {
    

    var option: ProfileOptionViewModelProtocol! {
        didSet { configure() }
    }
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.addSubview(iconImage)
        iconImage.centerInSuperview()
        view.backgroundColor = .systemBlue
        view.setDimensions(height: 40, width: 40)
        view.layer.cornerRadius = 40 / 2
        return view
    }()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 24, width: 24)
        iv.tintColor = .white
        return iv
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.onTintColor = .systemBlue
        return toggle
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(toggle)
        toggle.anchor(right: rightAnchor, paddingRight: 12)
        toggle.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        titleLabel.text = option.description
        iconImage.image = UIImage(systemName: option.iconImageName)
    }
}

