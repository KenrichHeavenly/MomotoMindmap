import SwiftUI
import UIKit

enum AppFont {
    private static let regularName = "AtkinsonHyperlegible-Regular"
    private static let boldName = "AtkinsonHyperlegible-Bold"

    static func font(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName = resolvedFontName(for: weight)

        if UIFont(name: fontName, size: size) != nil {
            return .custom(fontName, size: size)
        }

        return .system(size: size, weight: weight)
    }

    static func font(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        let size = pointSize(for: style)
        let fontName = resolvedFontName(for: weight)

        if UIFont(name: fontName, size: size) != nil {
            return .custom(fontName, size: size, relativeTo: style)
        }

        return .system(style, design: .default).weight(weight)
    }

    private static func resolvedFontName(for weight: Font.Weight) -> String {
        switch weight {
        case .bold, .semibold, .heavy, .black:
            return boldName
        default:
            return regularName
        }
    }

    private static func pointSize(for style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle:
            return 34
        case .title:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .subheadline:
            return 15
        case .callout:
            return 16
        case .caption:
            return 12
        case .caption2:
            return 11
        case .footnote:
            return 13
        default:
            return 17
        }
    }
}
