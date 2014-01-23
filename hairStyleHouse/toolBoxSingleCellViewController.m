//
//  toolBoxSingleCellViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-30.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "toolBoxSingleCellViewController.h"
#import "toolBoxViewController.h"
#import "BaiduMobStat.h"
@interface toolBoxSingleCellViewController ()

@end

@implementation toolBoxSingleCellViewController
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
    
    _fashionView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _fashionView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _fashionView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _fashionView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _protectView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _protectView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _protectView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _protectView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _storeView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _storeView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _storeView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _storeView.layer.masksToBounds = YES;//设为NO去试试
    
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

- (IBAction)fashinButtonClick:(id)sender
{
    wayView = nil;
    wayView= [[wayInforViewController alloc] init];
    wayView._hidden = @"no";
    wayView.style = @"4";

    [fatherController pushToViewController:wayView];
}

- (IBAction)protectButtonClick:(id)sender
{
    wayView = nil;
    wayView= [[wayInforViewController alloc] init];
    wayView._hidden = @"no";
    wayView.style = @"5";

    [fatherController pushToViewController:wayView];

}

- (IBAction)storeButtonClick:(id)sender
{
    wayView = nil;
    wayView= [[wayInforViewController alloc] init];
    wayView._hidden = @"no";
    wayView.style = @"1";

    [fatherController pushToViewController:wayView];

}
@end
