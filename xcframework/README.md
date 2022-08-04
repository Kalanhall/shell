build_xcframework.sh

1、简介
xcframework编译脚本

2、使用
    
    a. 将脚本放置在podspec文件同级目录（工程根目录）
    b. 在终端cd到该目录，将脚本.sh文件拖入终端，回车执行即可
    c. 输出产物统一创建在桌面XCFrameworkSpace文件夹中

3、工程podspec中设置

    a. 去除模拟器中的arm64架构，并指定架构进行编译

    s.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
        'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
    }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.xcconfig = { 'VALID_ARCHS' => 'arm64 arm64e x86_64' }
    
    b. 编译过程中报告 normal arm64等error信息，请安a步骤进行设置；如果是arm64或者其他问题 参考VALID_ARCHS设置，排除不必要的框架即可
