//
//  UITextView+HeightControl.m
//  XHTextInputView
//
//  Created by YZJMACMini on 2018/8/17.
//  Copyright © 2018年 Lxh.yzj. All rights reserved.
//

#import "UITextView+HeightControl.h"
#import <objc/runtime.h>



@implementation UITextView (HeightControl)

static char *MaxHeightKey = "MaxHeightKey";
static NSInteger stHeight;
static NSInteger stY;
NSLayoutConstraint *heightRaint;


-(void)setMaxNumberOfLines:(NSInteger)MaxNumberOfLines{
    objc_setAssociatedObject(self, MaxHeightKey, @(MaxNumberOfLines), OBJC_ASSOCIATION_ASSIGN);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChanged)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    
    //获取约束
    if (self.constraints.count != 0) {
        for (NSLayoutConstraint *raint in self.constraints) {
            if ( raint.firstAttribute == NSLayoutAttributeHeight) {
                heightRaint = raint;
                break;
            }
        }
    }
}


-(NSInteger )MaxNumberOfLines{
    NSNumber *numValue = objc_getAssociatedObject(self, MaxHeightKey);
    return [numValue integerValue];
}


-(void)textDidChanged{
    
    static dispatch_once_t disOnce;
    dispatch_once(&disOnce,^ {
        stHeight    =   self.frame.size.height;
        stY         =   self.frame.origin.y;
    });
    
    //文字高度
    NSInteger textHeight = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    // 最大高度 = (每行高度 * 总行数 + 文字上下间距)
    NSInteger maxTextH = ceil(self.font.lineHeight * self.MaxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
    
    if (textHeight > stHeight) {      //文字高度大于输入框高度

        if (maxTextH > textHeight) {   //最大高度大于文字高度

            if (heightRaint != nil) {  //xib
                heightRaint.constant = textHeight;
            }
            else{                      //Frame
                CGRect changeFrame      =   self.frame;
                changeFrame.origin.y    =   stY - (textHeight - stHeight);
                changeFrame.size.height =   textHeight;
                self.frame = changeFrame;
            }
        }
    }else{ //文字高度小于输入框高度
        if (heightRaint != nil) {
            heightRaint.constant = stHeight;
        }else{

            CGRect changeFrame      =   self.frame;
            changeFrame.origin.y    =   stY;
            changeFrame.size.height =   stHeight;
            self.frame = changeFrame;
        }
    }
}

@end
