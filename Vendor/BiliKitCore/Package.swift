// swift-tools-version: 6.2
import PackageDescription
// Loudness normalization's HLS mix tap uses macOS 27 SDK symbols. Enable only
// when building with a macOS 27+ SDK (see LoudnessProcessingTap.swift). macOS 15
// builds keep the feature compiled out.
let enableMacOS27AudioTap = false
let package = Package(name: "BiliKitCore", platforms: [.macOS(.v15), .iOS(.v26)], products: ["BiliModels", "BiliNetworking", "BiliPlayback"].map { .library(name: $0, targets: [$0]) }, targets: [
    .target(name: "BiliModels"), .target(name: "BiliApplication", dependencies: ["BiliModels"]), .target(name: "BiliNetworking"), .target(name: "BiliPlayback", dependencies: ["BiliModels", "BiliApplication", "BiliNetworking"], swiftSettings: enableMacOS27AudioTap ? [.define("ENABLE_MACOS_27_AUDIO_TAP")] : []), .testTarget(name: "BiliPlaybackTests", dependencies: ["BiliPlayback", "BiliModels", "BiliApplication", "BiliNetworking"], resources: [.copy("Fixtures")])
])
