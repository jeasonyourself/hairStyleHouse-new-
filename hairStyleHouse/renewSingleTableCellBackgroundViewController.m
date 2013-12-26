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
    workScroll=[[UIScrollView alloc] init];
    workScroll.delegate=self;
    workScroll.frame = CGRectMake(0, _worksLable.frame.origin.y+_worksLable.frame.size.height,320,_secondBackView.frame.size.height-_worksLable.frame.size.height-_worksLable.frame.origin.y);
    [_secondBackView addSubview:workScroll];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString* headStr=[infoDic objectForKey:@"head_photo"];
    NSString* nameStr = [infoDic objectForKey:@"username"];
    NSString* cityStr = [infoDic objectForKey:@"city"];
    NSString* fansStr = [infoDic objectForKey:@"fans_num"];
    NSString* fouceStr = [infoDic objectForKey:@"attention_num"];
    NSString* workStr = [infoDic objectForKey:@"works_num"];
    NSMutableArray * workArr ;
    if ([[infoDic objectForKey:@"portfolio"] isKindOfClass:[NSArray class]])
    {
        workArr = [infoDic objectForKey:@"portfolio"];
    }
    else
    {
    
    }
    NSString* messageStr = [infoDic objectForKey:@"newpm"];
    NSString* beaspeakStr = [infoDic objectForKey:@"reserve_num"];
    NSString* saveStr = [infoDic objectForKey:@"collect_num"];
    NSString* inforStr = [infoDic objectForKey:@"signature"];
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = nameStr;
    _addressLable.text = cityStr;
    [_fansButton setTitle:[NSString stringWithFormat:@"我的粉丝%@",fansStr] forState:UIControlStateNormal];
    [_fouceButton setTitle:[NSString stringWithFormat:@"我的关注%@",fouceStr] forState:UIControlStateNormal];
    _worksLable.text = [NSString stringWithFormat:@"作品集(共%@张)",workStr];
    _messageLable.text = [NSString stringWithFormat:@"%@",messageStr];
    _beaspeakLable.text = [NSString stringWithFormat:@"%@",beaspeakStr];
    _saveLable.text = [NSString stringWithFormat:@"%@",saveStr];
    _personInforText.text = inforStr;
    
    for (UIView* _sub in workScroll.subviews)
    {
        //        if ([_sub isKindOfClass:[AllAroundPullView class]]) {
        //            continue;
        //        }
        [_sub removeFromSuperview];
    }
    
    if (workArr.count>0)
    {
        [workScroll setContentSize:CGSizeMake(workArr.count*(60+10), 60)];
        if (workScroll.contentSize.width<workScroll.frame.size.width)
        {
            [workScroll setContentSize:CGSizeMake(workScroll.frame.size.width+1, workScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<workArr.count; i++)
        {
            rect=CGRectMake(60*i+10*(i+1), 10, 60, 60);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            [workImage setImageWithURL:[[workArr objectAtIndex:i] objectForKey:@"work_image"]];
            UIButton *newvideobutton=[UIButton buttonWithType:UIButtonTypeCustom];
            newvideobutton.backgroundColor=[UIColor clearColor];
            newvideobutton.tag=i;
            [newvideobutton addTarget:self  action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
            [newvideobutton setFrame:rect];
            [workScroll addSubview:workImage];
            [workScroll addSubview:newvideobutton];
        }
    }
}

-(void)selectImage:(UIButton*)button
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    scanView.uid = appDele.uid;
    scanView.worksOrsave = @"works";
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

- (IBAction)messageButtonClick:(id)sender
{
    fansAndfouceAndMassege = nil;
    fansAndfouceAndMassege =[[fansAndFouceAndmassegeViewController alloc] init];
    fansAndfouceAndMassege.fansOrFouceOrMessage=@"massege";
    [fatherController needAppdelegatePushToViewController:fansAndfouceAndMassege];
    
    
}

- (IBAction)myStoreButtonClick:(id)sender
{

}
- (IBAction)beaspeakButtonClick:(id)sender
{
    beaspeakView = nil;
    beaspeakView = [[beaspeakViewController alloc] init];
    [fatherController needAppdelegatePushToViewController:beaspeakView];
}

- (IBAction)saveButtonClick:(id)sender
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    scanView.uid = appDele.uid;
    scanView.worksOrsave = @"save";
    [fatherController needAppdelegatePushToViewController:scanView];
}

- (IBAction)checkInforButtonClick:(id)sender
{

}
- (IBAction)evaluateButtonClick:(id)sender
{

}
@end
