//
//  YYMEnterCodeView.m
//  TakeTaxiCar
//
//  Created by 云彦民 on 2018/9/4.
//  Copyright © 2018年 langyi. All rights reserved.
//

#import "YYMEnterCodeView.h"

#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kPAYMENT_WIDTH kSCREEN_WIDTH-80

static NSInteger const kPasswordCount = 6;
static CGFloat const kDotWidth        = 10;

@interface YYMEnterCodeView ()<UITextFieldDelegate>

//输入支付密码
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) NSMutableArray <UIButton *> *pwdIndicators;

@end

@implementation YYMEnterCodeView

-(instancetype)init {
    if (self = [super init]) {
        self.baseColor = [UIColor groupTableViewBackgroundColor];
        self.selectedLayerWithColor = [UIColor purpleColor];
        self.titleColor = [UIColor blackColor];
        [self initView];
        [self viewAddSubviews];
    }
    return self;
}

-(void)viewAddSubviews {
    CGFloat width = (kSCREEN_WIDTH - kDotWidth * 2)/kPasswordCount;
    for (int i = 0; i < kPasswordCount; i ++) {
        UIButton *dot = [[UIButton alloc]initWithFrame:CGRectMake(kDotWidth + i*width, 36, width, width)];
        dot.backgroundColor = [UIColor whiteColor];
        dot.titleLabel.font = [UIFont systemFontOfSize:80];
        [dot setTitleColor:self.titleColor forState:UIControlStateNormal];
        dot.layer.borderWidth = 1;
        dot.tag = 200 + i;
        dot.layer.borderColor = self.baseColor.CGColor;
        [dot addTarget:self action:@selector(dotButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dot];
        [self.pwdIndicators addObject:dot];
    }
}

-(void)changeTitleColor {
    for (UIButton *dot in self.pwdIndicators) {
        [dot setTitleColor:self.titleColor forState:UIControlStateNormal];
    }
}

-(void)dotButton:(UIButton *)sender {
    [self.pwdTextField becomeFirstResponder];
    for (UIButton *dot in self.pwdIndicators) {
        if (dot.tag == 200) {
            dot.layer.borderColor = self.selectedLayerWithColor.CGColor;
        }else {
             dot.layer.borderColor = self.baseColor.CGColor;
        }
    }
}

-(void)initView {
    [self addSubview:self.pwdTextField];
}

#pragma mark - delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= kPasswordCount && string.length) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }
    
    return YES;
}

- (void)dismiss {
    [self.pwdTextField resignFirstResponder];
    if (self.enterCodeBlock) {
        self.enterCodeBlock(self.pwdTextField.text);
    }
}

#pragma mark - action

- (void)textDidChange:(UITextField *)textField {
    [self setDotWithCount:textField.text.length];
    if (textField.text.length == 6) {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:.3f];
    }
}

- (void)setDotWithCount:(NSInteger)count {
    for (UIButton *dot in self.pwdIndicators) {
        [dot setTitle:@"" forState:UIControlStateNormal];
    }
    for (int i = 0; i< count; i++) {
        [((UIButton*)[self.pwdIndicators objectAtIndex:i])setTitle:@"·" forState:UIControlStateNormal];
    }
    for (int i = 0 ; i < self.pwdIndicators.count; i ++ ) {
        UIButton *dot = self.pwdIndicators[i];
        if (count < self.pwdIndicators.count) {
            if (i == count) {
                dot.layer.borderColor = self.selectedLayerWithColor.CGColor;
            }else {
               dot.layer.borderColor = self.baseColor.CGColor;
            }
        }else {
           dot.layer.borderColor = self.baseColor.CGColor;
        }
    }
    
}
#pragma mark - Setter

-(void)setBaseColor:(UIColor *)baseColor {
    _baseColor = baseColor;
}
-(void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self changeTitleColor];
}

-(void)setSelectedLayerWithColor:(UIColor *)selectedLayerWithColor {
    _selectedLayerWithColor = selectedLayerWithColor;
}

#pragma mark - Getter

- (UITextField *)pwdTextField {
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(kDotWidth, 36, 100, 28)];
        _pwdTextField.hidden = YES;
        _pwdTextField.delegate = self;
        _pwdTextField.keyboardType = UIKeyboardTypePhonePad;
        [_pwdTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTextField;
}

- (NSMutableArray *)pwdIndicators {
    if (_pwdIndicators == nil) {
        _pwdIndicators = [[NSMutableArray alloc]init];
    }
    return _pwdIndicators;
}


@end
