//
//  ViewController.m
//  LSGCDTimer
//
//  Created by 李丝思 on 2019/10/9.
//  Copyright © 2019 思. All rights reserved.
//

#import "ViewController.h"
#import "LSGCDTimer.h"


@interface ViewController ()
@property(copy,nonatomic)NSString *task;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    
    self.task = [LSGCDTimer execTask:^{
        NSLog(@"倒计时");
    } start:1 interval:1 repeats:YES async:YES];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"倒计时结束");
    [LSGCDTimer cancelTask:self.task];
    
}


@end
