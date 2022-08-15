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
  ],
  targets: [
    .executableTarget(
      name: "dbwr",
      dependencies: [
      ]
    ),
  ]
)
