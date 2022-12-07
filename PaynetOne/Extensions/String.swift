//
//  String.swift
//  PaynetOne
//
//  Created by vinatti on 04/01/2022.
//
import CommonCrypto
import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    func currencyFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
    
        var amountWithPrefix = self
    
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double))
    
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
    
        return formatter.string(from: number)!
    }
    
//    func isUrl(){
//        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        let matches = detector.matches(in: self, range: NSRange(location: 0, length: self.utf16.count))
//        for match in matches {
//            guard let range = Range(match.range, in: self) else {continue}
//            let url = self[range]
//        }
//    }
    
    func verifyUrl() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    func removeDiacritics() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    func phoneValidate() -> Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "(0[3|5|7|8|9])+([0-9]{8})")
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    func emailValidate() -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = self.range(of: emailPattern, options: .regularExpression)
        return result != nil
    }
    func attributedLastString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        let myRange = NSRange.init(location: attributedString.length - 1, length: 1)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myRange)
        return attributedString
    }
    func attributed(location: Int, length: Int) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        let myRange = NSRange.init(location: attributedString.length - location, length: length)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: myRange)
        return attributedString
    }
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    var checkazNomal: Bool {
        return self.range(of: "^[a-z]*$", options: .regularExpression) != nil
    }
    var checkazUpercase: Bool {
        return self.range(of: "^[A-Z]*$", options: .regularExpression) != nil
    }
    var checkNumber: Bool {
        return self.range(of: "^[0-9]*$", options: .regularExpression) != nil
    }
    var checkPass: Bool {
        return self.range(of: "^(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%&*()_+=|?{}.;\\[\\]~-])[a-zA-Z0-9!@#$%&*()_+=|?{}.;\\[\\]~-]{6,50}$", options: .regularExpression) != nil
    }
}
