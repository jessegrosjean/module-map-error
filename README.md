# Setapp + Swift/Rust package + module.modulemap error

This is an example project that reproduces a compiler error that I don't know how to fix.

1. App is a cocoa app that imports two swift packages.
2. One package is "MySwiftPackage". It wraps a small amount of rust code. It does the wrapping via code generation from the swift-bridge rust project. Build is down using `build-swift-package.sh`.
3. The other package is Setapp

If I add one package or the other on own then everything works fine. When I add both packages at the same time to App I get error:

```
Multiple commands produce '...Xcode/DerivedData/Workspace-ejeewzlcxbwwtbbihtdvnvgjkysh/Build/Products/Debug/include/module.modulemap'
```

# How to fix

I'm leaving the error in `main` branch, you can see changes required to fix in the `fix` branch. The fix is that in each built architecture in the RustXcframework.xcframework you need to put the module.modulemap, and other headers, into a specially named subfolder--the name header minus the .h.

For example move contents of:

```
RustXcframework.xcframework/macos-arm64_x86_64/Headers/
```

to:

```
RustXcframework.xcframework/macos-arm64_x86_64/Headers/my-rust-lib/
```

You will need to repeat this for each architecture.