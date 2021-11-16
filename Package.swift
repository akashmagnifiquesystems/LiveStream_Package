// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LiveStream_Package",
    platforms: [
            .macOS(.v10_12), .iOS(.v12), .tvOS(.v12)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LiveStream_Package",
            targets: ["LiveStream_Package"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            name: "Firebase",
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            .upToNextMajor(from: "8.7.0")
          ),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.4.3"),
        .package(url: "https://github.com/krimpedance/KRProgressHUD.git", from: "3.4.7"),
        .package(url: "https://github.com/akashmagnifiquesystems/Mux_Package.git", from: "1.0.1")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LiveStream_Package",
            dependencies: [   .product(name: "FirebaseAuth", package: "Firebase"),
                              .product(name: "FirebaseDatabase", package: "Firebase"),
                              .product(name: "FirebaseFirestore", package: "Firebase"),
                              .product(name: "FirebaseStorage", package: "Firebase"),
                              .product(name: "FirebaseMessaging", package: "Firebase")
                              ,"Alamofire","KRProgressHUD",
            ]),
        .testTarget(
            name: "LiveStream_PackageTests",
            dependencies: ["LiveStream_Package"]),
    ]
)
