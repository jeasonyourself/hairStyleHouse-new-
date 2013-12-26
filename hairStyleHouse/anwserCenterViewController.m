//
//  anwserCenterViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "anwserCenterViewController.h"

@interface anwserCenterViewController ()

@end

@implementation anwserCenterViewController
@synthesize _hidden;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    questionButton=[[UIButton alloc] init];
    questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [questionButton.layer setMasksToBounds:YES];
    [questionButton.layer setCornerRadius:10.0];
    [questionButton.layer setBorderWidth:1.0];
    [questionButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 1, 0, 0, 1 })];//边框颜色
    [questionButton setTitle:@"我要提问" forState:UIControlStateNormal];
    [questionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [questionButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [questionButton addTarget:self action:@selector(questionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    questionButton.frame = CGRectMake(10, 240, 300, 40);
    
    
    anwserButton=[[UIButton alloc] init];
    anwserButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [anwserButton.layer setMasksToBounds:YES];
    [anwserButton.layer setCornerRadius:10.0];
    [anwserButton.layer setBorderWidth:1.0];
    [anwserButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 1, 0, 0, 1 })];//边框颜色
    [anwserButton setTitle:@"我的问题" forState:UIControlStateNormal];
    [anwserButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [anwserButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [anwserButton addTarget:self action:@selector(anwserButtonClick) forControlEvents:UIControlEventTouchUpInside];
    anwserButton.frame = CGRectMake(10, 300, 300, 40);
    [self.view addSubview:questionButton];
    [self.view addSubview:anwserButton];
	// Do any additional setup after loading the view.
}

-(void)questionButtonClick
{
    pubQ = nil;
    pubQ = [[pubQViewController alloc] init];
    [self.navigationController pushViewController:pubQ animated:NO];
}

-(void)anwserButtonClick
{
    myAnwserView= nil;
    myAnwserView = [[myAnwserCenterViewController alloc] init];
    [self.navigationController pushViewController:myAnwserView animated:NO];
}
-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
   
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    
    
    Lab.text = @"问答中心";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
