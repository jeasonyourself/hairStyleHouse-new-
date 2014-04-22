//
//  renewSingleTableCellBackgroundViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-7.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "renewSingleTableCellBackgroundViewController.h"
#import "singleTableCellBackgroundViewController.h"
#import "UIImageView+WebCache.h"
#import "mineViewController.h"
#import "AppDelegate.h"
#import "UIImageView+MJWebCache.h"
#import "MobClick.h"
@interface renewSingleTableCellBackgroundViewController ()

@end

@implementation renewSingleTableCellBackgroundViewController

@synthesize fatherController;
@synthesize infoDic;
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
   
    _firstBackView.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _firstBackView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _firstBackView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstBackView.layer.masksToBounds = YES;//设为NO去试试
    
    _headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _headImage.layer.masksToBounds = YES;//设为NO去试试
    
    _clearPerson.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _clearPerson.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _clearPerson.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _clearPerson.layer.masksToBounds = YES;//设为NO去试试
    
    
    _myMessage.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _myMessage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myMessage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myMessage.layer.masksToBounds = YES;//设为NO去试试
    
    _myBeaspeak.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _myBeaspeak.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myBeaspeak.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myBeaspeak.layer.masksToBounds = YES;//设为NO去试试
    
    _myWorks.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _myWorks.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myWorks.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myWorks.layer.masksToBounds = YES;//设为NO去试试
    
    _setPrice.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _setPrice.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _setPrice.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _setPrice.layer.masksToBounds = YES;//设为NO去试试
    
    _shalong.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _shalong.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _shalong.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _shalong.layer.masksToBounds = YES;//设为NO去试试
    
    _toolBox.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _toolBox.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _toolBox.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _toolBox.layer.masksToBounds = YES;//设为NO去试试
    
    
    
    _mySet.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _mySet.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _mySet.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _mySet.layer.masksToBounds = YES;//设为NO去试试
    
    _myShowView.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _myShowView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myShowView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myShowView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _nameLable.text=@"0";
    _cityLable.text=@"0";
    _fansLable.text=@"0";
    _fouceLable.text=@"0";
    _introduceLable.text=@"0";
    _saveLable.text =@"0";
    if(iPhone5)
    {
        
    }
    else
    {
        _clearPerson.hidden=YES;
        _clearPersonButton.hidden=YES;
        _myMessage.hidden=YES;
        _messageButton.hidden=YES;
        _myBeaspeak.hidden=YES;
        _beaspeakButton.hidden=YES;
        _myWorks.hidden=YES;
        _myWorksButton.hidden=YES;
        _mySave.hidden=YES;
        _saveButton.hidden=YES;
        
        _setPrice.hidden=NO;
        _setPriceButton.hidden=NO;
        _shalong.hidden=NO;
        _shalongButton.hidden=NO;
        
        _toolBox.hidden=YES;
        _toolBoxButton.hidden=YES;
        
        _mySet.hidden=YES;
        _mySetButton.hidden=YES;
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"个人中心"];
    [MobClick beginLogPageView:cName];
    
    NSString* headStr=[infoDic objectForKey:@"head_photo"];
    NSString* nameStr = [infoDic objectForKey:@"username"];
    NSString* fansStr = [infoDic objectForKey:@"fans_num"];
    NSString* fouceStr = [infoDic objectForKey:@"attention_num"];
    NSString* cityStr = [infoDic objectForKey:@"city"];
    NSMutableArray * workArr ;
    if ([[infoDic objectForKey:@"portfolio"] isKindOfClass:[NSArray class]])
    {
        workArr = [infoDic objectForKey:@"portfolio"];
    }
    else
    {
    
    }
//    NSString* messageStr = [infoDic objectForKey:@"newpm"];
//    NSString* beaspeakStr = [infoDic objectForKey:@"reserve_num"];
    NSString* saveStr = [infoDic objectForKey:@"collect_num"];
    NSString* evaluateStr = [infoDic objectForKey:@"assess_num"];
    
//    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = nameStr;
    _cityLable.text=cityStr;
    _fansLable.text  = fansStr;
    _fouceLable.text = fouceStr;
    _introduceLable.text = evaluateStr;
    _saveLable.text = saveStr;
    
   
    if(iPhone5)
    {
        
    }
    else
    {
        
        _clearPerson.hidden=NO;
        _clearPersonButton.hidden=NO;
        _myMessage.hidden=NO;
        _messageButton.hidden=NO;
        _myBeaspeak.hidden=NO;
        _beaspeakButton.hidden=NO;
        _myWorks.hidden=NO;
        _myWorksButton.hidden=NO;
        _mySave.hidden=NO;
        _saveButton.hidden=NO;
        _setPrice.hidden=NO;
        _setPriceButton.hidden=NO;
        _shalong.hidden=NO;
        _shalongButton.hidden=NO;
        _toolBox.hidden=NO;
        _toolBoxButton.hidden=NO;
        
        _mySet.hidden=NO;
        _mySetButton.hidden=NO;
        
        
        _clearPerson.frame=CGRectMake(2, 350, 316, 37);
        _clearPersonButton.frame=CGRectMake(2, 350, 316, 37);
        _myMessage.frame=CGRectMake(2, 150, 316, 37);
        _messageButton.frame=CGRectMake(2, 150, 316, 37);
        _myBeaspeak.frame=CGRectMake(2, 188, 316, 37);
        _beaspeakButton.frame=CGRectMake(2, 188, 316, 37);
        _myWorks.frame=CGRectMake(2, 226, 316, 37);
        _myWorksButton.frame=CGRectMake(2, 226, 316, 37);
//        _mySave.frame=CGRectMake(2, 290, 316, 40);
//        _saveButton.frame=CGRectMake(2, 290, 316, 40);
        
        _setPrice.frame=CGRectMake(2, 264, 316, 37);
        _setPriceButton.frame=CGRectMake(2, 264, 316, 37);
        _shalong.frame=CGRectMake(2, 388, 316, 37);
        _shalongButton.frame=CGRectMake(2, 388, 316, 37);
        
        _toolBox.frame=CGRectMake(2, 436, 316, 37);
        _toolBoxButton.frame=CGRectMake(2, 436, 316, 37);
        _myShowView.frame=CGRectMake(2, 302, 316, 37);
        _myShowButton.frame=CGRectMake(2, 302, 316, 37);
        _mySet.frame=CGRectMake(2, 474, 316, 37);
        _mySetButton.frame=CGRectMake(2, 474, 316, 37);
    }

    
}
-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"个人中心"];
    [MobClick endLogPageView:cName];
}
-(void)selectImage:(UIButton*)button
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    scanView.uid = appDele.uid;
    scanView.worksOrsaveorCan = @"works";
    [fatherController needAppdelegatePushToViewController:scanView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)headButtonClick:(id)sender
{
    personInfor = nil;
    personInfor =[[personInforViewController alloc] init];
    personInfor._hidden =@"yes";
    [fatherController needAppdelegatePushToViewController:personInfor];
}

- (IBAction)myFansButtonClick:(id)sender {
    fansAndfouceAndMassege = nil;
    fansAndfouceAndMassege =[[fansAndFouceAndmassegeViewController alloc] init];
    fansAndfouceAndMassege.fansOrFouceOrMessage=@"noMassege";
    fansAndfouceAndMassege.fansOrFouce=@"fans";
    [fatherController needAppdelegatePushToViewController:fansAndfouceAndMassege];
}

- (IBAction)myFouceButtonClick:(id)sender
{
    fansAndfouceAndMassege = nil;
    fansAndfouceAndMassege =[[fansAndFouceAndmassegeViewController alloc] init];
    fansAndfouceAndMassege.fansOrFouceOrMessage=@"noMassege";
    fansAndfouceAndMassege.fansOrFouce=@"fouce";
    [fatherController needAppdelegatePushToViewController:fansAndfouceAndMassege];
    
}
- (IBAction)evaluateButtonClick:(id)sender
{
    lookEvaluate=nil;
    lookEvaluate = [[lookEvaluateViewController alloc] init];
    lookEvaluate.uid = [infoDic objectForKey:@"uid"];
    lookEvaluate._hidden = @"yes";

    [fatherController  needAppdelegatePushToViewController:lookEvaluate];
}


- (IBAction)saveButtonClick:(id)sender
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    scanView.uid = appDele.uid;
    scanView._hidden = @"yes";
    scanView.worksOrsaveorCan = @"save";
    [fatherController needAppdelegatePushToViewController:scanView];
}


- (IBAction)checkInforButtonClick:(id)sender
{

}

- (IBAction)clearPersonButtonClick:(id)sender
{
    sameCityView = nil;
    sameCityView= [[sameCityViewController alloc] init];
    sameCityView._hidden = @"yes";
    [fatherController needAppdelegatePushToViewController:sameCityView];
}
- (IBAction)messageButtonClick:(id)sender
{
    fansAndfouceAndMassege = nil;
    fansAndfouceAndMassege =[[fansAndFouceAndmassegeViewController alloc] init];
    fansAndfouceAndMassege.fansOrFouceOrMessage=@"massege";
    [fatherController needAppdelegatePushToViewController:fansAndfouceAndMassege];
}


- (IBAction)beaspeakButtonClick:(id)sender
{
    beaspeakView = nil;
    beaspeakView = [[beaspeakViewController alloc] init];
    beaspeakView.dresserOrCommen=@"dresser";
    [fatherController needAppdelegatePushToViewController:beaspeakView];
}

- (IBAction)myWorksButtonClick:(id)sender
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    scanView.uid = appDele.uid;
    scanView.worksOrsaveorCan = @"works";
//    scanView.selfOrOther = @"self";
    scanView._hidden = @"yes";
    [fatherController needAppdelegatePushToViewController:scanView];
}
- (IBAction)myShowButtonClick:(id)sender
{
    
    myShowView1 = nil;
    myShowView1 = [[myShowViewController alloc] init];
    myShowView1._hidden = @"yes";
    [fatherController needAppdelegatePushToViewController:myShowView1];
}
- (IBAction)setPriceButtonClick:(id)sender//会做发型
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    scanView.uid = appDele.uid;
    scanView.worksOrsaveorCan = @"can";
//    scanView.selfOrOther = @"other";
    scanView._hidden = @"yes";
    [fatherController needAppdelegatePushToViewController:scanView];
}

- (IBAction)shalongButtonClick:(id)sender
{
    sureView = nil;
    sureView = [[sureStoreViewController alloc] init];
    sureView._hidden = @"yes";
    [fatherController needAppdelegatePushToViewController:sureView];
}
- (IBAction)toolBoxButtonClick:(id)sender
{
    toolBoxView = nil;
    toolBoxView = [[toolBoxViewController alloc] init];
    toolBoxView._hidden = @"yes";
    [fatherController needAppdelegatePushToViewController:toolBoxView];

}
- (IBAction)mySetButtonClick:(id)sender
{
    mySetView = nil;
    mySetView = [[mySetViewController alloc] init];
    mySetView._hidden = @"yes";
    [ fatherController needAppdelegatePushToViewController:mySetView];
}


@end
