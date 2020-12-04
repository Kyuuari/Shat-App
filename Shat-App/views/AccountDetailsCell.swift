//
//  AccountDetailsView.swift
//  Shat-App
//
//  Created by Brendon H. on 2020-12-02.
//

import Foundation
import UIKit

protocol AccountDetailsCellDelegate: class {
    func editProfileCell(_ cell: AccountDetailsCell, wantsToUpdateUserWith value: String)
}

class AccountDetailsCell: UITableViewCell {
        
    var viewModel: AccountDetailsViewModel! {
        didSet { configure() }
    }
    
    weak var delegate: AccountDetailsCellDelegate?
    
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
        iv.setDimensions(height: 28, width: 28)
        iv.tintColor = .white
        return iv
    }()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.addTarget(self, action: #selector(updateUser), for: .editingDidEnd)
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        addSubview(textField)
        textField.anchor(right: rightAnchor, paddingRight: 12)
        textField.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateUser(sender: UITextField) {
        guard let value = sender.text else { return }
        delegate?.editProfileCell(self, wantsToUpdateUserWith: value)
    }
    
    func configure() {
        titleLabel.text = viewModel.option.description
        iconImage.image = UIImage(systemName: viewModel.option.iconImageName)
        textField.text = viewModel.textFieldValue
        
        if viewModel.option.description == "Email" {
            iconImage.setDimensions(height: 24, width: 24)
        }
    }
}
