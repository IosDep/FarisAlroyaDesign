//
//  PrimaryTextField.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 08/01/2024.
//

import UIKit

class PrimaryTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.delegate = self
        self.backgroundColor = .white
        layer.cornerRadius = 16
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.4238466024, green: 0.1600308716, blue: 0.6470095515, alpha: 0.5)
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
            .foregroundColor: #colorLiteral(red: 0.4336867332, green: 0.4839242697, blue: 0.7569896579, alpha: 1)
        ])
        semanticContentAttribute = .forceLeftToRight
        self.textAlignment =  .right

        // Add keyboard toolbar setup
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "تم", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension PrimaryTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.337254902, alpha: 1)
        textField.layer.borderWidth = 1.0
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0.1538879573, green: 0.1893022954, blue: 0.348248899, alpha: 0.5)
        textField.layer.borderWidth = 0.5
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        _ = (currentText as NSString).replacingCharacters(in: range, with: string)
        return true
    }

    // Selector method to dismiss the keyboard
    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
