//
//  dresserDetailViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "dresserInforViewController.h"
@interface dresserDetailViewController ()

@end

@implementation dresserDetailViewController
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
    NSString* fansStr = [infoDic objectForKey:@"assess_num"];
    NSString* workStr = [infoDic objectForKey:@"works_num"];
    NSMutableArray * workArr;
    if ([[infoDic objectForKey:@"portfolio"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[infoDic objectForKey:@"portfolio"] isKindOfClass:[NSArray class]])
    {
       workArr = [infoDic objectForKey:@"portfolio"];
        
    }
    
    NSString* inforStr = [infoDic objectForKey:@"signature"];

    NSString* storeStr = [infoDic objectForKey:@"store_name"];
    NSString* mobileStr = [infoDic objectForKey:@"mobile"];
    NSString* storeAddressStr = [infoDic objectForKey:@"store_city"];
    NSString* concerStr = [infoDic objectForKey:@"isconcerns"];//是否关注

    NSString* clear_reserve = [infoDic objectForKey:@"clear_reserve"];//是否可以预约

    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = nameStr;
    _addressLable.text = cityStr;
    [_fansButton setTitle:[NSString stringWithFormat:@"查看评价%@",fansStr] forState:UIControlStateNormal];

    _worksLable.text = [NSString stringWithFormat:@"作品集(共%@张)",workStr];
    _inforTextVuew.text = [NSString stringWithFormat:@"%@",inforStr];
    _storeNameLable.text = [NSString stringWithFormat:@"%@",storeStr];
    _mobileLable.text = [NSString stringWithFormat:@"%@",mobileStr];
    _cityLable.text = [NSString stringWithFormat:@"%@",storeAddressStr];
    
    
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
    
    if ([clear_reserve isEqualToString:@"1"])
    {
        [_bespeakButton setTitle:@"预约发型师" forState:UIControlStateNormal];
    }
    else
    {
        [_bespeakButton setTitle:@"尚未开通预约" forState:UIControlStateNormal];
    }
    
        [fatherController refreashNav:concerStr];//设置是否关注
  
    

}
-(void)selectImage:(UIButton*)button
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    scanView.uid=[infoDic objectForKey:@"uid"];
    scanView._hidden = @"no";
    scanView.worksOrsaveorCan = @"works";
    [fatherController pushToViewController:scanView];
}

- (IBAction)myFansButtonClick:(id)sender//查看看评价
{
    lookEvaluate=nil;
    lookEvaluate = [[lookEvaluateViewController alloc] init];
    lookEvaluate.uid = [infoDic objectForKey:@"uid"];
    lookEvaluate._hidden = @"no";

    [fatherController  pushToViewController:lookEvaluate];
}

- (IBAction)myFouceButtonClick:(id)sender//私聊
{
    talkView=nil;
    talkView = [[talkViewController alloc] init];
    talkView.uid = [infoDic objectForKey:@"uid"];
    [fatherController  pushToViewController:talkView];

    
}

- (IBAction)bespeakDresserClick:(id)sender
{
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
