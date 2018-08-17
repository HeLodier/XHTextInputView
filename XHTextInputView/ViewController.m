//
//  ViewController.m
//  XHTextInputView
//
//  Created by YZJMACMini on 2018/8/17.
//  Copyright © 2018年 Lxh.yzj. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+HeightControl.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputTextView.MaxNumberOfLines = 4;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
