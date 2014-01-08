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
    _firstBackView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _firstBackView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstBackView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _clearPerson.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _clearPerson.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _clearPerson.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _clearPerson.layer.masksToBounds = YES;//设为NO去试试
    
    
    _myMessage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _myMessage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myMessage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myMessage.layer.masksToBounds = YES;//设为NO去试试
    
    _myBeaspeak.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _myBeaspeak.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myBeaspeak.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myBeaspeak.layer.masksToBounds = YES;//设为NO去试试
    
    _myWorks.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _myWorks.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _myWorks.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _myWorks.layer.masksToBounds = YES;//设为NO去试试
    
    _setPrice.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _setPrice.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _setPrice.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _setPrice.layer.masksToBounds = YES;//设为NO去试试
    
    _shalong.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _shalong.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _shalong.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _shalong.layer.masksToBounds = YES;//设为NO去试试
    
    _toolBox.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _toolBox.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _toolBox.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _toolBox.layer.masksToBounds = YES;//设为NO去试试
    
    
    
    _mySet.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _mySet.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _mySet.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _mySet.layer.masksToBounds = YES;//设为NO去试试
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString* headStr=[infoDic objectForKey:@"head_photo"];
    NSString* nameStr = [infoDic objectForKey:@"username"];
    NSString* fansStr = [infoDic objectForKey:@"fans_num"];
    NSString* fouceStr = [infoDic objectForKey:@"attention_num"];
//    NSString* workStr = [infoDic objectForKey:@"works_num"];
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
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = nameStr;
    _fansLable.text  = fansStr;
    _fouceLable.text = fouceStr;
    _introduceLable.text = evaluateStr;
    _saveLable.text = saveStr;
    
    
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
