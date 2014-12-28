//
//  ZSStatusBarHUD.h
//  weibo
//
//  Created by ZhuiYi on 14/12/18.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZSStatusBarHUD : NSObject
/**
 *  电池栏弹出成功消息
 *
 *  @param message 消息内容
 */
+ (void)showSuccess:(NSString *)message;
/**
 *  电池栏弹出失败消息
 *
 *  @param message 消息内容
 */
+ (void)showError:(NSString *)message;
/**
 *  电池栏显示加载消息
 *
 *  @param message 消息内容
 */
+ (void)showLoading:(NSString *)message;
/**
 *  隐藏加载消息
 */
+ (void)hideLoading;

@end
