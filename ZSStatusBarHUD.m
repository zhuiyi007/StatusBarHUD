//
//  ZSStatusBarHUD.m
//  weibo
//
//  Created by ZhuiYi on 14/12/18.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "ZSStatusBarHUD.h"

// 自定义button,调整图片和文字的位置
@interface ZSStatusBarButton : UIButton
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@end
@implementation ZSStatusBarButton
#pragma mark - 加载控件的懒加载
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadingView.hidesWhenStopped = YES;
        [_loadingView startAnimating];
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    
    CGFloat titleW = [[self titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    CGFloat imageW = 20;
    CGFloat imageH = 20;
    CGFloat imageX = self.centerX - titleW / 2 - imageW;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.loadingView.center = self.imageView.center;
    
}

@end

static NSTimeInterval ZSAnimateDuration = 0.25;
static UIWindow *_window;
static ZSStatusBarButton *_button;
@implementation ZSStatusBarHUD

#pragma mark - 初始化设置
+ (void)initialize
{
    _window = [[UIWindow alloc] init];
    _window.height = 20;
    _window.backgroundColor = [UIColor blackColor];
    _window.width = [UIScreen mainScreen].bounds.size.width;
    _window.windowLevel = UIWindowLevelAlert;
    _window.transform = CGAffineTransformMakeTranslation(0, -_window.height);
    _window.hidden = NO;
    
    _button = [[ZSStatusBarButton alloc] init];
    _button.frame = _window.bounds;
    _button.titleLabel.textColor = [UIColor whiteColor];
    _button.titleLabel.font = [UIFont systemFontOfSize:13];
    _button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_window addSubview:_button];
}

#pragma mark - 成功提示
+ (void)showSuccess:(NSString *)message
{
    [self showMessage:message image:@"avatar_grassroot"];
}

#pragma mark - 失败提示
+ (void)showError:(NSString *)message
{
     [self showMessage:message image:@"avatar_vip"];
}

#pragma mark - 正在加载,显示转圈
+ (void)showLoading:(NSString *)message
{
    // 如果窗口正在显示,就返回
    if (_window.hidden == NO) return;
    // 显示窗口
    _window.hidden = NO;
    [_button setTitle:message forState:UIControlStateNormal];
    // 清除图片
    [_button setImage:nil forState:UIControlStateNormal];
    // 显示圈圈
    [_button.loadingView startAnimating];
    [UIView animateWithDuration:ZSAnimateDuration animations:^{
        _window .transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 隐藏正在加载
+ (void)hideLoading
{
    [UIView animateWithDuration:ZSAnimateDuration animations:^{
        _window.transform = CGAffineTransformMakeTranslation(0, -_window.height);
    }completion:^(BOOL finished) {
        [_button.loadingView stopAnimating];
        _window.hidden = YES;
    }];
}

#pragma mark - 抽取成功和失败的公共方法
+ (void)showMessage:(NSString *)message image:(NSString *)image
{
    // 如果窗口正在显示,就返回
    if (_window.hidden == NO && !_button.loadingView.isAnimating) return;
    _window.hidden = NO;
    [_button setTitle:message forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [_button.loadingView stopAnimating];
    [UIView animateWithDuration:ZSAnimateDuration animations:^{
        _window .transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:ZSAnimateDuration delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            _window.transform = CGAffineTransformMakeTranslation(0, -_window.height);
        } completion:^(BOOL finished) {
            _window.hidden = YES;
        }];
    }];
}

@end

