//
//  YLClearGirlViewController.m
//  ShowGirl
//
//  Created by lyl on 15/7/5.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLClearGirlViewController.h"
#import "YLClearGirlView.h"
@interface YLClearGirlViewController ()<YLClearGirlViewDelegate>

@end

@implementation YLClearGirlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // Do any additional setup after loading the view
    YLClearGirlView *clearView =[[YLClearGirlView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:clearView];
    clearView.clearGirlViewDelegate =self;
    clearView.imageModal = self.imageModal;
  
    
}
-(void)clearGirlViewClosed{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
