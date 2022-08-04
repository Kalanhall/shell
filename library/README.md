build_lib.sh

1、简介
.a编译脚本

2、使用
        
    a. Xcode -> File -> New -> Target -> Library -> 输入target名称，规则 {库名}Binary，例如在ToolKit工程中，创建lib时，命名为：ToolKitBinary，工程目录下自动会生成ToolKitBinary文件夹
    b. 将源码所有文件直接拖入ToolKitBinary文件夹中，Choose options选择 Create groups / ToolKitBinary 即可
    c. 在TAEGETS -> Build Phases 中 + 添加 New Headers Phase，设置头文件即可
    d. 将脚本放置在podspec文件同级目录（工程根目录）
    e. 在终端cd到该目录，将脚本.sh文件拖入终端，回车执行即可
    f. 输出产物统一创建在桌面LibrarySpace文件夹中

