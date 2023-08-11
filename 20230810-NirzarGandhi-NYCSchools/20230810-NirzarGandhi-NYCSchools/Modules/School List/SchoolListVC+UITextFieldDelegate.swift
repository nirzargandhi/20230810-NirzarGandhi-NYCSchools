//
//  SchoolListVC+UITextFieldDelegate.swift
//  20230810-NirzarGandhi-NYCSchools
//

//MARK: - UITextField Delegate Extension
extension SchoolListVC : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()

            setData()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let strTextFieldValue: NSString = (textField.text ?? "") as NSString
        let strText = strTextFieldValue.replacingCharacters(in: range, with: string)
        var isValid = false

        if strText.isEmpty {
            isValid = false
        } else {
            isValid = true
        }

        if isValid {
            arrSchoolList = arrMainSchoolList?.filter({ $0.school_name?.lowercased().contains(find: strText.lowercased()) ?? false })
        } else {
            arrSchoolList = arrMainSchoolList ?? []
        }

        return true
    }
}

