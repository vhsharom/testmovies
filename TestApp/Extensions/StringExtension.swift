//
//  StringExtension.swift
//
//

import Foundation

extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    func convertToAttributeString() -> NSAttributedString?{
        if let data = self.data(using: String.Encoding.isoLatin1, allowLossyConversion: false){
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
            }
        }
        return nil
    }
}
