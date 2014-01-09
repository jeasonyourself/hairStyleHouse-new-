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
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
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
    
    _firstView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _firstView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _firstView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstView.layer.masksToBounds = YES;//设为NO去试试
    
//    _headBackView.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    _headBackView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
//    _headBackView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
//    _headBackView.layer.masksToBounds = YES;//设为NO去试试
    
    _headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _headImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _headImage.layer.masksToBounds = YES;//设为NO去试试
    
    _secondView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _secondView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _secondView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _secondView.layer.masksToBounds = YES;//设为NO去试试
    
    _thirdView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _thirdView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _thirdView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _thirdView.layer.masksToBounds = YES;//设为NO去试试
    
    _askButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _askButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _askButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _askButton.layer.masksToBounds = YES;//设为NO去试试
    
    _fouceButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _fouceButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _fouceButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _fouceButton.layer.masksToBounds = YES;//设为NO去试试
    
    
    workScroll=[[UIScrollView alloc] init];
    workScroll.delegate=self;
    workScroll.frame = CGRectMake(55, 5,320-60,90);
    [_thirdView addSubview:workScroll];
    
    canScroll=[[UIScrollView alloc] init];
    canScroll.delegate=self;
    canScroll.frame = CGRectMake(55, 90,320-60,90);
    [_thirdView addSubview:canScroll];
  
    
    NSString* headStr=[infoDic objectForKey:@"head_photo"];
    NSString* nameStr = [infoDic objectForKey:@"username"];
    NSString* cityStr = [infoDic objectForKey:@"city"];
    NSString* fansStr = [infoDic objectForKey:@"assess_num"];
    NSString* workStr = [infoDic objectForKey:@"works_num"];
    NSMutableArray * workArr;
    if ([[infoDic objectForKey:@"worksInfo"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[infoDic objectForKey:@"worksInfo"] isKindOfClass:[NSArray class]])
    {
        workArr = [infoDic objectForKey:@"worksInfo"];
        
    }
    
    NSMutableArray * canArr;
    if ([[infoDic objectForKey:@"willdoInfo"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[infoDic objectForKey:@"willdoInfo"] isKindOfClass:[NSArray class]])
    {
        canArr = [infoDic objectForKey:@"willdoInfo"];
        
    }
    
    NSString* inforStr = [infoDic objectForKey:@"signature"];
    
    NSString* storeStr = [infoDic objectForKey:@"store_name"];
    NSString* mobileStr = [infoDic objectForKey:@"telephone"];
    NSString* storeAddressStr = [infoDic objectForKey:@"store_address"];
    NSString* concerStr = [infoDic objectForKey:@"isconcerns"];//是否关注
    
//    NSString* clear_reserve = [infoDic objectForKey:@"clear_reserve"];//是否可以预约
    
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = nameStr;
    _addressLable.text = cityStr;
    [_fansButton setTitle:[NSString stringWithFormat:@"查看评价%@",fansStr] forState:UIControlStateNormal];
    
    _worksLable.text = [NSString stringWithFormat:@"作品集(共%@张)",workStr];
    _signature.text = [NSString stringWithFormat:@"%@",inforStr];
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
        [workScroll setContentSize:CGSizeMake(workArr.count*(60+10), 80)];
        if (workScroll.contentSize.width<workScroll.frame.size.width)
        {
            [workScroll setContentSize:CGSizeMake(workScroll.frame.size.width+1, workScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<workArr.count; i++)
        {
            rect=CGRectMake(60*i+10*(i+1), 10, 60, 80);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            
            workImage.layer.cornerRadius = 3;//设置那个圆角的有多圆
            workImage.layer.borderWidth =0;//设置边框的宽度，当然可以不要
            workImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
            workImage.layer.masksToBounds = YES;//设为NO去试试
            
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
    
    
    
    for (UIView* _sub in canScroll.subviews)//会做列表
    {
        //        if ([_sub isKindOfClass:[AllAroundPullView class]]) {
        //            continue;
        //        }
        [_sub removeFromSuperview];
    }
    
    if (canArr.count>0)
    {
        [canScroll setContentSize:CGSizeMake(canArr.count*(60+10), 80)];
        if (canScroll.contentSize.width<canScroll.frame.size.width)
        {
            [canScroll setContentSize:CGSizeMake(canScroll.frame.size.width+1, canScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<canArr.count; i++)
        {
            rect=CGRectMake(60*i+10*(i+1), 10, 60, 80);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            
            workImage.layer.cornerRadius = 3;//设置那个圆角的有多圆
            workImage.layer.borderWidth =0;//设置边框的宽度，当然可以不要
            workImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
            workImage.layer.masksToBounds = YES;//设为NO去试试
            
            [workImage setImageWithURL:[[canArr objectAtIndex:i] objectForKey:@"work_image"]];
            UIButton *newvideobutton=[UIButton buttonWithType:UIButtonTypeCustom];
            newvideobutton.backgroundColor=[UIColor clearColor];
            newvideobutton.tag=i;
            [newvideobutton addTarget:self  action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
            [newvideobutton setFrame:rect];
            [canScroll addSubview:workImage];
            [canScroll addSubview:newvideobutton];
        }
    }

    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([[infoDic objectForKey:@"uid"] isEqualToString:appDele.uid]) {
        _askButton.enabled=NO;
    }
    else
    {
        _askButton.enabled=YES;

    }
    
    if ([concerStr isEqualToString:@"1"])
    {
        [_fouceButton setTitle:@"取消关注" forState:UIControlStateNormal];
        _fouceButton.tag=1;
    }
    else
    {
        [_fouceButton setTitle:@"关注" forState:UIControlStateNormal];
        _fouceButton.tag=0;
        
    }
    
//    [fatherController refreashNav:concerStr];//设置是否关注
    
    

    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
   
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

- (IBAction)commentButtonClick:(id)sender {
}

- (IBAction)askButtonClick:(id)sender
{
    
    talkView=nil;
    talkView = [[talkViewController alloc] init];
    talkView.uid = [infoDic objectForKey:@"uid"];
    [fatherController  pushToViewController:talkView];
}

- (IBAction)fouceButtonClick:(id)sender {
    
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=follow"]];
    request.delegate=self;
    request.tag=2;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:[infoDic objectForKey:@"uid"] forKey:@"touid"];
    [request setPostValue:appDele.type forKey:@"type"];
    [request setPostValue:@"2" forKey:@"totype"];
    
    if ( _fouceButton.tag==1)//取消关注
    {
        [request setPostValue:@"0" forKey:@"status"];
        [_fouceButton setTitle:@"关注TA" forState:UIControlStateNormal];
        [_fouceButton setBackgroundColor:[UIColor colorWithRed:88.0/256.0 green:193.0/256.0 blue:189.0/256.0 alpha:1.0]];
        
        _fouceButton.tag=0;
        
    }
    else//加关注
    {
        [request setPostValue:@"1" forKey:@"status"];
        [_fouceButton setTitle:@"取消关注" forState:UIControlStateNormal];
        [_fouceButton setBackgroundColor:[UIColor colorWithRed:172.0/256.0 green:172.0/256.0 blue:172.0/256.0 alpha:1.0]];
        _fouceButton.tag=1;
        
    }
    [request startAsynchronous];
    //在这里关注或取消关注

}
@end
