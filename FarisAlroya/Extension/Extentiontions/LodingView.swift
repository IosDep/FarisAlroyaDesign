//
//  LodingView.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 11/01/2024.
//

import Foundation
import UIKit

class LoadingView: UIView {

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoadingView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoadingView()
    }

    private func setupLoadingView() {
        addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func startAnimating() {
        loadingIndicator.startAnimating()
        isHidden = false
    }

    func stopAnimating() {
        loadingIndicator.stopAnimating()
        isHidden = true
    }
}
