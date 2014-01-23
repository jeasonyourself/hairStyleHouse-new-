//
//  dresserToolBoxSingleCellViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-31.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserToolBoxSingleCellViewController.h"
#import "toolBoxViewController.h"
#import "BaiduMobStat.h"
@interface dresserToolBoxSingleCellViewController ()

@end

@implementation dresserToolBoxSingleCellViewController
@synthesize  fatherController;
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
    
    _invitedView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _invitedView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _invitedView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _invitedView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _talkPointView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _talkPointView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _talkPointView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _talkPointView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _wayNewsView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _wayNewsView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _wayNewsView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _wayNewsView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _shalongView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _shalongView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _shalongView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _shalongView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _myShowView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _myShowView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myShowView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myShowView.layer.masksToBounds = YES;//设为NO去试试
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"发型工具箱"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"发型工具箱"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)invitedButtonClick:(id)sender
{
    inviteView = nil;
    inviteView= [[inviteViewController alloc] init];
    inviteView._hidden = @"no";
    [fatherController pushToViewController:inviteView ];
}

- (IBAction)talkPointButtonClick:(id)sender
{
    hotView = nil;
    hotView= [[hotTalkViewController alloc] init];
    hotView._hidden = @"no";
    [fatherController pushToViewController:hotView ];

}

- (IBAction)wayNewsButtonClick:(id)sender
{
    wayView = nil;
    wayView= [[wayInforViewController alloc] init];
    wayView._hidden = @"no";
    wayView.style = @"3";
    
    [fatherController pushToViewController:wayView];
    
}
- (IBAction)myShowButtonClick:(id)sender
{

    myShowView1 = nil;
    myShowView1 = [[myShowViewController alloc] init];
    myShowView1._hidden = @"no";
    [ fatherController pushToViewController:myShowView1];
}
- (IBAction)shalongButtonClick:(id)sender
{
    wayView = nil;
    wayView= [[wayInforViewController alloc] init];
    wayView._hidden = @"no";
    wayView.style = @"1";
    
    [fatherController pushToViewController:wayView];
}

@end
