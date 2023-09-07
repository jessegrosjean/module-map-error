# Setapp + Swift/Rust package + module.modulemap error

This is an example project that reproduces a compiler error that I don't know how to fix.

1. App is a cocoa app that imports two swift packages.
2. One package is "MySwiftPackage". It wraps a small amount of rust code. It does the wrapping via code generation from the swift-bridge rust project. Build is down using `build-swift-package.sh`.
3. The other package is Setapp

If I add one package or the other on own then everything works fine. When I add both packages at the same time to App I get error:

```
Multiple commands produce '...Xcode/DerivedData/Workspace-ejeewzlcxbwwtbbihtdvnvgjkysh/Build/Products/Debug/include/module.modulemap'
```

To fix and make the project compile you can remove Setapp from the App targets Frameworks, Libraries, and Embedded content section.

I'm not sure how to work around this problem. Thoughts?
