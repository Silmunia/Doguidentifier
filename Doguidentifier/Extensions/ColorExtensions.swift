//
//  ColorExtensions.swift
//  Doguidentifier
//
//  Created by Pedro Henrique Costa on 08/02/21.
//

import UIKit

extension UIColor {

	// MARK: - Color Hex Code Approach
	convenience init?(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		var rgb: UInt64 = 0

		var red: CGFloat = 0.0
		var green: CGFloat = 0.0
		var blue: CGFloat = 0.0
		var alpha: CGFloat = 1.0

		let length = hexSanitized.count

		guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

		if length == 6 {
			red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
			green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
			blue = CGFloat(rgb & 0x0000FF) / 255.0

		} else if length == 8 {
			red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
			green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
			blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
			alpha = CGFloat(rgb & 0x000000FF) / 255.0

		} else {
			return nil
		}

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	// MARK: - Custom Colors
	static var dogWhite: UIColor { return UIColor(hex: "#F7F7FF")! }

	static var dogYellow: UIColor { return UIColor(hex: "#FFD04E")! }

	static var dogBlue: UIColor { return UIColor(hex: "#587FDA")! }

	static var dogGreen: UIColor { return UIColor(hex: "#00B99B")! }

	static var dogPaleGreen: UIColor { return UIColor(hex: "#3A786E")! }

	static var dogRed: UIColor { return UIColor(hex: "#EF004D")! }

	static var dogPurple: UIColor { return UIColor(hex: "#5B2A86")! }

	static var dogPalePurple: UIColor { return UIColor(hex: "#BB84D3")! }

	static var dogNavy: UIColor { return UIColor(hex: "#073B4C")! }

	static var dogPaleNavy: UIColor { return UIColor(hex: "#3B6876")! }

	static var dogPaleRed: UIColor { return UIColor(hex: "#A53C5A")! }

}
