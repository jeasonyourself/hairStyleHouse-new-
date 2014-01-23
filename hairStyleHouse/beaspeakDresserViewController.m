//
//  beaspeakDresserViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "beaspeakDresserViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface beaspeakDresserViewController ()

@end

@implementation beaspeakDresserViewController
@synthesize orderId;
@synthesize dresserOrCommen;

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
    _introView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _introView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _introView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _introView.layer.masksToBounds = YES;//设为NO去试试
    
    orderInfor= [[NSDictionary alloc] init];
    dresserArray = [[NSMutableArray alloc] init];
    
    
    sureButton=[[UIButton alloc] init];
    sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton.layer setMasksToBounds:YES];
    [sureButton.layer setCornerRadius:5.0];
    [sureButton.layer setBorderWidth:1.0];
    [sureButton setBackgroundColor:[UIColor colorWithRed:244.0/256.0 green:22.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [sureButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    sureButton.frame = CGRectMake(40,400, 100, 30);
    
    
    cancelButton=[[UIButton alloc] init];
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton.layer setMasksToBounds:YES];
    [cancelButton.layer setCornerRadius:5.0];
    [cancelButton.layer setBorderWidth:1.0];
    [cancelButton setBackgroundColor:[UIColor colorWithRed:172.0/256.0 green:172.0/256.0 blue:172.0/256.0 alpha:1.0]];
    [cancelButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(180, 400, 100, 30);
    
    
    sureButton1=[[UIButton alloc] init];
    sureButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton1.layer setMasksToBounds:YES];
    [sureButton1.layer setCornerRadius:5.0];
    [sureButton1.layer setBorderWidth:1.0];
    [sureButton1 setBackgroundColor:[UIColor colorWithRed:244.0/256.0 green:22.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [sureButton1.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sureButton1 setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [sureButton1 addTarget:self action:@selector(sureButton1Click) forControlEvents:UIControlEventTouchUpInside];
    sureButton1.frame = CGRectMake(50,400, 220, 30);
    
    
//    cancelButton1=[[UIButton alloc] init];
//    cancelButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton1.layer setMasksToBounds:YES];
//    [cancelButton1.layer setCornerRadius:5.0];
//    [cancelButton1.layer setBorderWidth:1.0];
//    [cancelButton1 setBackgroundColor:[UIColor colorWithRed:172.0/256.0 green:172.0/256.0 blue:172.0/256.0 alpha:1.0]];
//    [cancelButton1.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
//    [cancelButton1 setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [cancelButton1 addTarget:self action:@selector(cancelButton1Click) forControlEvents:UIControlEventTouchUpInside];
//    cancelButton1.frame = CGRectMake(50, 400, 220, 30);
    
    [self.view addSubview:sureButton];
    [self.view addSubview:cancelButton];
    [self.view addSubview:sureButton1];
//    [self.view addSubview:cancelButton1];
    
    [_secondView addSubview:sureButton];
    [_secondView addSubview:cancelButton];
    [_secondView addSubview:sureButton1];
//    [_secondView addSubview:cancelButton1];
    
    _secondView.hidden=YES;
    
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        
//        _secondView.hidden=NO;
//        [_secondView addSubview:sureButton];
//        [_secondView addSubview:cancelButton];
    }
    else
    {
//        _secondView.hidden=YES;
//        [self.view addSubview:sureButton];
//        [self.view addSubview:cancelButton];

    }
    sureButton.hidden=YES;
    cancelButton.hidden = YES;
    sureButton1.hidden=YES;
//    cancelButton1.hidden = YES;
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"我的预约"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"我的预约"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)sureButtonClick
{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=edit_status"]];
    request.delegate=self;
    request.tag=101;
    [request setPostValue:@"2" forKey:@"status"];
    [request setPostValue:self.orderId forKey:@"order_id"];
    [request startAsynchronous];
}

-(void)cancelButtonClick
{
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=edit_status"]];
    request.delegate=self;
    request.tag=102;
    [request setPostValue:@"3" forKey:@"status"];
    [request setPostValue:self.orderId forKey:@"order_id"];
    [request startAsynchronous];
}

-(void)sureButton1Click
{
    
    
}

-(void)cancelButton1Click
{

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
    [leftButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
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
    Lab.text = @"我的预约";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)getData
{
    if ([dresserOrCommen isEqualToString:@"dresser"])
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=reserve_info"]];
        request.delegate=self;
        request.tag=11;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:self.orderId forKey:@"order_id"];
        [request startAsynchronous];
    }
    else
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=current"]];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:self.orderId forKey:@"order_id"];
        [request startAsynchronous];
    }
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
//    if (dresserArray!=nil) {
//        [dresserArray removeAllObjects];
//    }
    if (request.tag==1)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"用户查看预约详情dic:%@",dic);
        if ([[dic objectForKey:@"order_info"] isKindOfClass:[NSString class]]) {
            
        }
        else
        {
        orderInfor = [dic objectForKey:@"order_info"];
        }
        
        
        if ([[orderInfor objectForKey:@"order_type"] isEqualToString:@"1"])//预约的是发型师
        {
            _secondView.hidden=YES;
            
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=notice_show"]];
            request.delegate=self;
            request.tag=2;
            [request setPostValue:[orderInfor objectForKey:@"to_uid"] forKey:@"uid"];
            [request startAsynchronous];
            
            if ([[orderInfor objectForKey:@"status"] isEqualToString:@"1"])
            {
                
                
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = NO;
            }
            else if ([[orderInfor objectForKey:@"status"] isEqualToString:@"2"])
            {
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=NO;
//                cancelButton1.hidden = YES;
            }
            else
            {
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = YES;
            }
            
        }
        else//预约的是发型
        {
            
            _secondView.hidden=NO;
            if ([[orderInfor objectForKey:@"status"] isEqualToString:@"1"])
            {
                
                
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = NO;
            }
            else if ([[orderInfor objectForKey:@"status"] isEqualToString:@"2"])
            {
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=NO;
//                cancelButton1.hidden = YES;
            }
            else
            {
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = YES;
            }
            

        }

    }
    
     if (request.tag==2)
    { 
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约发型师详情dic:%@",dic);
        if ([[[dic objectForKey:@"notice_info"] objectForKey:@"info"] isKindOfClass:[NSString class]])
        {
        
        }
        else if ([[[dic objectForKey:@"notice_info"] objectForKey:@"info"] isKindOfClass:[NSArray class]])
        {
          dresserArray = [[dic objectForKey:@"notice_info"] objectForKey:@"info"];
                    
        }
        
        
        
        [self freashView];

    }
    
    
    if (request.tag==11)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师查看详情dic:%@",dic);
        
        
        if ([[dic objectForKey:@"order_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else
        {
            orderInfor = [dic objectForKey:@"order_info"];
            
        }
        if ([[orderInfor objectForKey:@"order_type"] isEqualToString:@"1"])//预约的是发型师
        {
            _secondView.hidden=YES;
            
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=notice_show"]];
            request.delegate=self;
            request.tag=2;
            [request setPostValue:[orderInfor objectForKey:@"to_uid"] forKey:@"uid"];
            [request startAsynchronous];
            
            if ([[orderInfor objectForKey:@"status"] isEqualToString:@"1"])
            {
                
                
                sureButton.hidden=NO;
                cancelButton.hidden = NO;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = YES;
            }
           
            else
            {
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = YES;
            }
            
            
        }
        else//预约的是发型
        {
            
            _secondView.hidden=NO;
            if ([[orderInfor objectForKey:@"status"] isEqualToString:@"1"])
            {
                
                
                sureButton.hidden=NO;
                cancelButton.hidden = NO;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = YES;
            }
            
            else
            {
                sureButton.hidden=YES;
                cancelButton.hidden = YES;
                sureButton1.hidden=YES;
//                cancelButton1.hidden = YES;
            }

        }
        [self freashView];
        
    }

    
    if (request.tag==101)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约发型师详情dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"接受预约成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            sureButton.hidden=YES;
            cancelButton.hidden = YES;
            sureButton1.hidden=YES;
//            cancelButton1.hidden = YES;
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"接受预约失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    if (request.tag==102)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约发型师详情dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"拒绝预约成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            sureButton.hidden=YES;
            cancelButton.hidden = YES;
            sureButton1.hidden=YES;
//            cancelButton1.hidden = YES;
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"拒绝预约失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)freashView
{
    
    if ([dresserOrCommen isEqualToString:@"dresser"])
    {
        NSString * nameStr = [orderInfor objectForKey:@"my_name"];
        NSString * mobileStr = [orderInfor objectForKey:@"my_tel"];
        NSString * timeStr = [orderInfor objectForKey:@"reserve_time"];
        NSString * hourStr = [orderInfor objectForKey:@"reserve_hour"];
//        NSString * orderStr = [orderInfor objectForKey:@"order_type"];
        NSString * typeStr = [orderInfor objectForKey:@"reserve_type"];
        NSString * priceStr = [orderInfor objectForKey:@"reserve_price"];
        NSString * imageStr= [orderInfor objectForKey:@"image_path"];
        NSLog(@"%@",orderInfor);
        
        if ([[orderInfor objectForKey:@"order_type"] isEqualToString:@"1"])//预约的是发型师
        {
            _storeLable.text=[NSString stringWithFormat:@"预约者姓名: %@",nameStr];
            _mobileLable.text =[NSString stringWithFormat:@"预约号码: %@",mobileStr];
            _addressLable.text =[NSString stringWithFormat:@"预约时间: %@%@",timeStr,hourStr];
            
                _brespeakLable.text =[NSString stringWithFormat:@"预约类型: %@",typeStr];
                
            
//                _otherTypeLable.text =[NSString stringWithFormat:@"预约下图发型"];
//                [_picImage setImageWithURL:[NSURL URLWithString:imageStr]];
            
            
            _priceLable.text =[NSString stringWithFormat:@"%@元",priceStr];
            
            if (dresserArray.count==1) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0] ];
                
            }
            else if (dresserArray.count==2) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                
                
            }
            else if (dresserArray.count==3) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                _thirdLable.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
            }
            else if (dresserArray.count==4) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                _thirdLable.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
                _forthLable.text= [NSString stringWithFormat:@"4、%@",[dresserArray objectAtIndex:3]];
            }
            else if (dresserArray.count==5) {
                
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                _thirdLable.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
                _forthLable.text= [NSString stringWithFormat:@"4、%@",[dresserArray objectAtIndex:3]];
                _fifthLable.text= [NSString stringWithFormat:@"5、%@",[dresserArray objectAtIndex:4]];
            }
            else if (dresserArray.count==0)
            {
                
            }

        }
            else//预约的是发型
            {
                _otherNameLable.text=[NSString stringWithFormat:@"预约者姓名: %@",nameStr];
                _otherMobileLable.text =[NSString stringWithFormat:@"预约号码: %@",mobileStr];
                _otherTimeLable.text =[NSString stringWithFormat:@"预约时间: %@%@",timeStr,hourStr];
                
                _otherTypeLable.text =[NSString stringWithFormat:@"预约类型: %@",typeStr];
                
                
                _otherTypeLable.text =[NSString stringWithFormat:@"预约下图发型"];
               [_picImage setImageWithURL:[NSURL URLWithString:imageStr]];
                
                
                _otherMoneyLable.text =[NSString stringWithFormat:@"%@元",priceStr];
            }
        
        
    }
    else
    {
    
//    NSString * headStr= [orderInfor objectForKey:@"head_photo"];
    NSString * nameStr = [orderInfor objectForKey:@"to_username"];
    NSString * storeStr = [orderInfor objectForKey:@"store_name"];
    NSString * mobileStr = [orderInfor objectForKey:@"telephone"];
    NSString * addressStr = [orderInfor objectForKey:@"store_address"];
    NSString * timeStr = [orderInfor objectForKey:@"reserve_time"];
    NSString * hourStr = [orderInfor objectForKey:@"reserve_hour"];
    NSString * typeStr = [orderInfor objectForKey:@"reserve_type"];
    NSString * priceStr = [orderInfor objectForKey:@"reserve_price"];
        NSString * imageStr= [orderInfor objectForKey:@"image_path"];
        if ([[orderInfor objectForKey:@"order_type"] isEqualToString:@"1"])//预约的是发型师
        {
            _nameLable.text=nameStr;
            _storeLable.text = [NSString stringWithFormat:@"发型店名称:%@",storeStr];
            _mobileLable.text =[NSString stringWithFormat:@"预约号码:%@",mobileStr];
            _addressLable.text = [NSString stringWithFormat:@"详细地址:%@",addressStr];
            _brespeakLable.text =[NSString stringWithFormat:@"预约时间:%@%@",timeStr,hourStr];
            _typeLable.text =[NSString stringWithFormat:@"预约类型:%@",typeStr];
             _priceLable.text =[NSString stringWithFormat:@"%@元",priceStr];
            
            if (dresserArray.count==1) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0] ];
                
            }
            else if (dresserArray.count==2) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                
                
            }
            else if (dresserArray.count==3) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                _thirdLable.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
            }
            else if (dresserArray.count==4) {
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                _thirdLable.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
                _forthLable.text= [NSString stringWithFormat:@"4、%@",[dresserArray objectAtIndex:3]];
            }
            else if (dresserArray.count==5) {
                
                _firstLable.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
                _secondLable.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
                _thirdLable.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
                _forthLable.text= [NSString stringWithFormat:@"4、%@",[dresserArray objectAtIndex:3]];
                _fifthLable.text= [NSString stringWithFormat:@"5、%@",[dresserArray objectAtIndex:4]];
            }
            else if (dresserArray.count==0)
            {
                
            }

        }
        else//预约的是发型
        {
            _otherNameLable.text=[NSString stringWithFormat:@"发型店名称: %@",nameStr];
            _otherMobileLable.text =[NSString stringWithFormat:@"预约号码: %@",mobileStr];
            _otherTimeLable.text =[NSString stringWithFormat:@"预约时间: %@%@",timeStr,hourStr];
            
            _otherTypeLable.text =[NSString stringWithFormat:@"预约类型: %@",typeStr];
            
            
            _otherTypeLable.text =[NSString stringWithFormat:@"预约下图发型"];
            [_picImage setImageWithURL:[NSURL URLWithString:imageStr]];
            
            
            _otherMoneyLable.text =[NSString stringWithFormat:@"%@元",priceStr];
        }
    
//    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
  
    
       }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)headButtonClick:(id)sender
{
    dreserView =nil;
    dreserView =[[dresserInforViewController alloc] init];
    dreserView.uid = [orderInfor objectForKey:@"to_uid"];
    [self.navigationController pushViewController:dreserView animated:NO];
}
@end
