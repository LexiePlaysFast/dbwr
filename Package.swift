// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "dbwr",
  products: [
    .executable(
      name: "dbwr",
      targets: [
        "dbwr"
      ]
    ),
  ],
  dependencies: [
    .package(
      name: "JavaScriptKit",
      url: "https://github.com/swiftwasm/JavaScriptKit.git",
      from: "0.10.0"
    ),
  ],
  targets: [
    .executableTarget(
      name: "dbwr",
      dependencies: [
        "JavaScriptKit",
      ]
    ),
  ]
)
