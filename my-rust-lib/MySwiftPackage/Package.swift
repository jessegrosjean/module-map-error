// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "MySwiftPackage",
	products: [
		.library(
			name: "MySwiftPackage",
			targets: ["MySwiftPackage"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "MySwiftPackage",
			dependencies: ["RustXcframework"])
	]
)
	