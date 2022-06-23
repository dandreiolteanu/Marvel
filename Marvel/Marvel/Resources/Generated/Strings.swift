// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Characters {
    /// Comics
    internal static let comicsSectionTitle = L10n.tr("Localizable", "Characters.comicsSectionTitle")
    /// Comic name not available.
    internal static let emptyComicTitlePlaceholder = L10n.tr("Localizable", "Characters.emptyComicTitlePlaceholder")
    /// This superhero has no description, I think he was not an Avenger.
    internal static let emptyDescriptionPlaceholder = L10n.tr("Localizable", "Characters.emptyDescriptionPlaceholder")
    /// This superhero is nameless
    internal static let emptyNamePlaceholder = L10n.tr("Localizable", "Characters.emptyNamePlaceholder")
    /// Character information
    internal static let personalInformationSectionTitle = L10n.tr("Localizable", "Characters.personalInformationSectionTitle")
    /// Search the next avenger
    internal static let searchPlaceholder = L10n.tr("Localizable", "Characters.searchPlaceholder")
  }

  internal enum Reusable {
    /// No superheroes found.
    internal static let emptyContent = L10n.tr("Localizable", "Reusable.emptyContent")
    /// We've encountered an error. Please try again!
    internal static let errorContent = L10n.tr("Localizable", "Reusable.errorContent")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
