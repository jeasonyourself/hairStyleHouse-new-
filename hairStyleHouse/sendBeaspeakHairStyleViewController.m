//
//  sendBeaspeakHairStyleViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "sendBeaspeakHairStyleViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SBJson.h"
#import "BaiduMobStat.h"
@interface sendBeaspeakHairStyleViewController ()

@end

@implementation sendBeaspeakHairStyleViewController
@synthesize inforDic;
@synthesize headImg;
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
    [self refreashNav];
    [self refreashNavLab];
    oldPriceString = [[NSString alloc] init];
    saleString = [[NSString alloc] init];
    newPriceString = [[NSString alloc] init];
    dateString = [[NSString alloc] init];
    dateString1 = [[NSString alloc] init];
    timeString = [[NSString alloc] init];
     timeDataString= [[NSString alloc] init];
    sevenButtonArr = [[NSMutableArray alloc ] initWithObjects:_dateOneButton,_dateTwoButton,_dateThirdButton,_dateFourButton,_dateFiveButton,_dateSixButton,_dateSevenButton, nil];
    
    twelveButtonArr = [[NSMutableArray alloc ] initWithObjects:_nineClockButton,_tenClockButton,_elevenClockButton,_twelveClockButton,_thirteenClockButton,_forteenClockButton,_fifteenClockButton,_sixteenClockButton,_seventeenClockButton,_eighteenClockButton,_ninteenClockButton,_twentyClockButton, nil];
    
    
    _firstView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _firstView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _firstView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstView.layer.masksToBounds = YES;//设为NO去试试
    
    _headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _headImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _headImage.layer.masksToBounds = YES;//设为NO去试试
    for (UIButton * _button in twelveButtonArr)//日期按钮全设置未圆角
    {
        _button.layer.cornerRadius = 5;//设置那个圆角的有多圆
        _button.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        _button.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        _button.layer.masksToBounds = YES;//设为NO去试试
        
    }
    _sendBeaspeakButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sendBeaspeakButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sendBeaspeakButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sendBeaspeakButton.layer.masksToBounds = YES;//设为NO去试试
//    NSString * headStr= [self.inforDic objectForKey:@"work_image"];
    NSString * nameStr = [self.inforDic objectForKey:@"long_service"];
    oldPriceString= [self.inforDic objectForKey:@"price"];
    saleString= [self.inforDic objectForKey:@"rebate"];
    newPriceString = [self.inforDic objectForKey:@"reserve_price"];
    NSString * addressStr = [self.inforDic objectForKey:@"store_address"];
    
    
    
    [_headImage setImageWithURL:[NSURL URLWithString:headImg]];
    
   
    if ([nameStr isEqualToString:@"0"]) {
        _nameLable.text=@"暂无";
    }
    else
    {
        _nameLable.text=[NSString stringWithFormat:@"%@",nameStr];
    }
    
    
    if ([oldPriceString isEqualToString:@"0.00"]) {
        _oldPrice.text=@"暂无";
    }
    else
    {
        _oldPrice.text=[NSString stringWithFormat:@"%@元",oldPriceString];
    }
    
    if ([newPriceString isEqualToString:@"0.00"]) {
        _nowPrice.text=@"暂无";
    }
    else
    {
        _nowPrice.text=[NSString stringWithFormat:@"%@元（%@折扣）",newPriceString,saleString];
    }
    
    _addressLable.text=addressStr;
    
    
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"M/d/EEEE"];
    for (int i = 1; i < 8; i ++) {
        NSString *dateStr = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:i * secondsPerDay]];
        NSLog(@"dateString:%@",dateStr);
        NSArray *array = [dateStr componentsSeparatedByString:@"/"];
        if (i==1) {
            _dayOneLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeOneLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];//哪一天
        }
        else if (i==2)
        {
            _dayTwoLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeTwoLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        }
        else if (i==3)
        {
            _dayThirdLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeThirdLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
            
        }
        else if (i==4)
        {
            _dayFourLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeFourLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        }
        else if (i==5)
        {
            _dayFiveLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeFiveLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        }
        else if (i==6)
        {
            _daySixLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeSixLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        }
        else if (i==7)
        {
            _daySevenLable.text = [NSString stringWithFormat:@"%@-%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            _timeSevenLable.text =[NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        }
    }
    
    
//    NSString * priceStr = [inforDic objectForKey:@"price_info"];
//    NSArray *array = [priceStr componentsSeparatedByString:@"_"];
    //    if ([_sign isEqualToString:@"all"])
    //    {
//    _oldPrice.text = [NSString stringWithFormat:@"￥%@",[array objectAtIndex:0]];
//    NSInteger oldInt= [[array objectAtIndex:0] integerValue];
//    float saleInt= [[array objectAtIndex:4] floatValue];
//    NSInteger nowInt = oldInt*saleInt/10;
//    _nowPrice.text = [NSString stringWithFormat:@"￥%d(%@折)",nowInt,[array objectAtIndex:4]];
//    
//    oldPriceString = [array objectAtIndex:0];
//    saleString = [array objectAtIndex:4];
    
    timeString = @"9:00";
    _getTimeLable.text = [NSString stringWithFormat:@"%@%@",dateString,timeString];
    
    timeDataString = [NSString stringWithFormat:@"%@ %@",_dayOneLable.text,timeString];
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

-(void)refreashNavLab
{
    
    
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"预约发型详细";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)viewDidAppear:(BOOL)animated
{
    

    NSString* cName = [NSString stringWithFormat:@"预约发型详细"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    newTextViewFrame.origin.y =newTextViewFrame.size.height+80-self.view.bounds.size.height;//自己加的，特为此界面定制
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    _backView.frame = newTextViewFrame;
    NSLog(@"_backView.frame:%@",NSStringFromCGRect(_backView.frame));
    
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    _backView.frame = self.view.bounds;
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"预约发型详细"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



- (IBAction)dateButtonClick:(id)sender
{
    UIButton * btn = (UIButton*)sender;
    
    for (UIButton * _button in sevenButtonArr) {
        if (_button.tag==btn.tag)
        {
            [_button setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] ];
        }
        else
        {
            [_button setBackgroundColor:[UIColor blackColor] ];
        }
    }
    
    
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"M/d/EEEE"];
    
    NSString *dateStr = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:1 * secondsPerDay]];
    NSLog(@"dateString:%@",dateStr);
    NSArray *array = [dateStr componentsSeparatedByString:@"/"];
    
    NSString *dateStr2 = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:2 * secondsPerDay]];
    NSArray *array2 = [dateStr2 componentsSeparatedByString:@"/"];
    
    NSString *dateStr3 = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:3 * secondsPerDay]];
    NSArray *array3 = [dateStr3 componentsSeparatedByString:@"/"];
    
    NSString *dateStr4 = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:4 * secondsPerDay]];
    NSArray *array4 = [dateStr4 componentsSeparatedByString:@"/"];
    
    NSString *dateStr5 = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:5 * secondsPerDay]];
    NSArray *array5 = [dateStr5 componentsSeparatedByString:@"/"];
    
    NSString *dateStr6 = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:6 * secondsPerDay]];
    NSArray *array6 = [dateStr6 componentsSeparatedByString:@"/"];
    
    NSString *dateStr7 = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:7 * secondsPerDay]];
    NSArray *array7 = [dateStr7 componentsSeparatedByString:@"/"];
    
    
    
    switch (btn.tag) {
        case 1:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2]];//哪一天
            break;
        case 2:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1],[array2 objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array2 objectAtIndex:0],[array2 objectAtIndex:1],[array2 objectAtIndex:2]];//哪一天
            break;
        case 3:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array3 objectAtIndex:0],[array3 objectAtIndex:1],[array3 objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array3 objectAtIndex:0],[array3 objectAtIndex:1],[array3 objectAtIndex:2]];//哪一天
            break;
        case 4:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array4 objectAtIndex:0],[array4 objectAtIndex:1],[array4 objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array4 objectAtIndex:0],[array4 objectAtIndex:1],[array4 objectAtIndex:2]];//哪一天
            break;
        case 5:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array5 objectAtIndex:0],[array5 objectAtIndex:1],[array5 objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array5 objectAtIndex:0],[array5 objectAtIndex:1],[array5 objectAtIndex:2]];//哪一天
            break;
        case 6:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array6 objectAtIndex:0],[array6 objectAtIndex:1],[array6 objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array6 objectAtIndex:0],[array6 objectAtIndex:1],[array6 objectAtIndex:2]];//哪一天
            break;
            
        case 7:
            dateString = [NSString stringWithFormat:@"%@月%@日%@",[array7 objectAtIndex:0],[array7 objectAtIndex:1],[array7 objectAtIndex:2]];//哪一天
            dateString1 = [NSString stringWithFormat:@"%@-%@%@",[array7 objectAtIndex:0],[array7 objectAtIndex:1],[array7 objectAtIndex:2]];//哪一天
            break;
        default:
            break;
    }
    _getTimeLable.text = [NSString stringWithFormat:@"%@%@",dateString,timeString];
    timeDataString = [NSString stringWithFormat:@"%@ %@",_dayOneLable.text,timeString];
}


- (IBAction)timeClockButtonClick:(id)sender
{
    UIButton * btn = (UIButton*)sender;
    
    for (UIButton * _button in twelveButtonArr)
    {
        if (_button.tag==btn.tag)
        {
            [_button setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] ];
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        }
        else
        {
            [_button setBackgroundColor:[UIColor clearColor] ];
            [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        }
        
    }
    
    switch (btn.tag) {
        case 9:
            timeString = @"9:00";
            break;
        case 10:
            timeString = @"10:00";
            break;
        case 11:
            timeString = @"11:00";
            break;
        case 12:
            timeString = @"12:00";
            break;
        case 13:
            timeString = @"13:00";
            break;
        case 14:
            timeString = @"14:00";
            break;
            
        case 15:
            timeString = @"15:00";
            break;
            
        case 16:
            timeString = @"16:00";
            break;
        case 17:
            timeString = @"17:00";
            break;
        case 18:
            timeString = @"18:00";
            break;
        case 19:
            timeString = @"19:00";
            break;
        case 20:
            timeString = @"20:00";
            break;
            
            
        default:
            break;
    }
    _getTimeLable.text = [NSString stringWithFormat:@"%@%@",dateString,timeString];
    timeDataString = [NSString stringWithFormat:@"%@ %@",_dayOneLable.text,timeString];
}

- (IBAction)sendBeaspeakButtonClick:(id)sender
{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_mobileField.text];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([_mobileField.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入姓名" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        ASIFormDataRequest* request;
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Reserve&a=reservation"]]];
        
        [request setPostValue:@"2"forKey:@"order_type"];//预约发型为2
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        [request setPostValue:appDele.uid forKey:@"my_uid"];
        [request setPostValue:[self.inforDic objectForKey:@"uid"]forKey:@"to_uid"];
        
        
        [request setPostValue:dateString1 forKey:@"reserve_time"];
        [request setPostValue:timeString forKey:@"reserve_hour"];
        
        [request setPostValue:oldPriceString forKey:@"price"];
        [request setPostValue:saleString forKey:@"rebate"];
        [request setPostValue:[_nameField text] forKey:@"my_name"];
        [request setPostValue:[_mobileField text] forKey:@"my_tel"];
        
        [request setPostValue:[inforDic objectForKey:@"long_service" ] forKey:@"long_service"];
        [request setPostValue:[inforDic objectForKey:@"work_id"] forKey:@"work_id"];
//        [request setPostValue:styleString forKey:@"reserve_type"];//预约发型没有这一项
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M-d HH:mm"];
        NSDate* date = [formatter dateFromString:timeDataString];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        NSLog(@"timeDataString:%@",timeDataString);
        NSLog(@"timeSp:%@",timeSp);
        
        [request setPostValue:timeSp forKey:@"expire_time"];
        request.delegate=self;
        [request startAsynchronous];
        
        
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    NSData*jsondata = [request responseData];
    NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
    
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSLog(@"预约是否成功dic:%@",dic);
    if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        [self leftButtonClick];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"您尚有未完成预约" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}



-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}
- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:_nameField];
    [self textFiledReturnEditing:_mobileField];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
