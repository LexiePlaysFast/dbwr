// swift-tools-version:5.10
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
      url: "https://github.com/swiftwasm/carton",
      from: "1.0.0"
    ),
    .package(
      url: "https://github.com/swiftwasm/JavaScriptKit.git",
      from: "0.19.0"
    ),
    .package(
      url: "https://github.com/LexiePlaysFast/UnderworldRandomizer.git",
      branch: "master"
    ),
  ],
  targets: [
    .executableTarget(
      name: "dbwr",
      dependencies: [
        "JavaScriptKit",
        .product(name: "LibRando", package: "UnderworldRandomizer"),
        .product(name: "LibSeeded", package: "UnderworldRandomizer"),
      ],
      resources: [
        .copy("Resources/rando.css"),
        .copy("Resources/v0/"),
      ]
    ),
  ]
)
