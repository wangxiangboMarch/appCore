# APPCoreLibrary

## iOS Develop Tool Code Collection.

![GitHub](https://github.com/wangxiangboMarch/appCore.git)

## 如何安装 - How to install
- CococaPods

    完整安装 - Full instal
    ``` ruby
        pod 'APPCoreLibrary', :branch => 'master'
    ```
    单个模块 - Single module install

    ``` ruby
        pod 'APPCoreLibrary/PUMLog', :branch => 'master'
        pod 'APPCoreLibrary/PUMLogConsole', :branch => 'master'
        pod 'APPCoreLibrary/PUMUtils', :branch => 'master'
    ```

-  Swift Package Manager

    完整安装 - Full instal
    ``` swift
        dependencies: [
            .package(url: "https://github.com/wangxiangboMarch/appCore.git", .branch("master"))
        ]
    ```
    单个模块 - Single module install

    ``` swift
        dependencies: [
            .package(url: "https://github.com/wangxiangboMarch/appCore.git", .branch("master"))
        ]
    ```
