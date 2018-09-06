//
//  YYMEnterCodeView.h
//  TakeTaxiCar
//
//  Created by 云彦民 on 2018/9/4.
//  Copyright © 2018年 langyi. All rights reserved.
//

//密码输入框封装

#import <UIKit/UIKit.h>

@interface YYMEnterCodeView : UIView

@property (nonatomic, copy)void (^enterCodeBlock)(NSString *code);


/**
 基本颜色 默认为groupTableViewBackgroundColor
 */
@property (nonatomic, strong)UIColor *baseColor;

/**
 选中的颜色 默认为紫色
 */
@property (nonatomic, strong)UIColor *selectedLayerWithColor;

/**
 黑点的颜色 默认为黑色
 */
@property (nonatomic, strong)UIColor *titleColor;

@end
