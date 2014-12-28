StatusBarHUD
============

电池栏的HUD提示栏


覆盖电池栏弹出提示信息

弹出成功消息
+ (void)showSuccess:(NSString *)message;

弹出失败消息
+ (void)showError:(NSString *)message;

正在加载消息
+ (void)showLoading:(NSString *)message;

隐藏正在加载
+ (void)hideLoading;
