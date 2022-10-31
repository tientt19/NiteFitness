//
//  ErrorView.swift
//  myElcom
//
//  Created by Tiến Trần on 01/08/2022.
//

import Foundation
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func onRetryButtonDidTapped(_ errorView: UIView)
}


class ErrorView: UIView {

    private var errorMessage: String = ""
    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefatults()
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        errorMessage = message
        setupDefatults()
    }

    private func setupDefatults() {
        backgroundColor = UIColor.white
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(51)
        }
        let imageView = UIImageView(image: UIImage(named: ""))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(147)
            make.height.equalTo(98)
        }
        // Title Label
        let titleLabel = createTitleLabel()

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
        }
        // Content Label
        let contentLabel = createContentLabel()
        view.addSubview(contentLabel)

        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }

        let retryButton = createRetryButton()
        view.addSubview(retryButton)

        retryButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(19)
            make.centerX.bottom.equalToSuperview()
            make.width.equalTo(146)
            make.height.equalTo(36)
        }
    }

    private func createTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = "Đã có lỗi xảy ra"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.darkText
        titleLabel.textAlignment = .center
        return titleLabel
    }

    private func createContentLabel() -> UILabel {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor(hex: "")
        contentLabel.textAlignment = .center
        contentLabel.text = errorMessage
        return contentLabel
    }

    private func createRetryButton() -> UIButton {
        let retryButton = UIButton()
        retryButton.backgroundColor = UIColor.blue
        retryButton.setTitle("Thử lại", for: .normal)
        retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        retryButton.cornerRadius = 18
        retryButton.setTitleColor(UIColor.white, for: .normal)
        retryButton.addTarget(self, action: #selector(buttonRetryDidTapped), for: .touchUpInside)
        return retryButton
    }

    @objc func buttonRetryDidTapped() {
        delegate?.onRetryButtonDidTapped(self)
    }
}
