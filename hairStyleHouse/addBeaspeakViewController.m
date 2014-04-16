//
//  addBeaspeakViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-9.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "addBeaspeakViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SBJson.h"

#import "MobClick.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface addBeaspeakViewController ()

@end

@implementation addBeaspeakViewController
@synthesize _hidden;
@synthesize inforDic;
@synthesize scrollView;
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
    [self refreashNav];
    [self refreashNavLab];
    yearArray = [[NSMutableArray alloc] init];
    hoursArray = [[NSMutableArray alloc] init];
    minutesArray = [[NSMutableArray alloc] init];
    _secondView.hidden=NO;
    _otherSecondView.hidden=YES;
    select=NO;
    styleString = [[NSString alloc] init];
    styleString = @"洗剪吹";
    oldPriceString = [[NSString alloc] init];
    saleString = [[NSString alloc] init];
    newPriceString = [[NSString alloc] init];
    dateString = [[NSString alloc] init];
    dateString1 = [[NSString alloc] init];

    timeString = [[NSString alloc] init];
    timeDataString= [[NSString alloc] init];
    
    firstArr = [[NSMutableArray alloc] init];
    secondArr = [[NSMutableArray alloc] init];
    fourButtonArr = [[NSMutableArray alloc ] initWithObjects:_styleOneButton,_styleTwoButton,_styleThirdButton,_styleFourButton, nil];
    
    sevenButtonArr = [[NSMutableArray alloc ] initWithObjects:_dateOneButton,_dateTwoButton,_dateThirdButton,_dateFourButton,_dateFiveButton,_dateSixButton,_dateSevenButton, nil];
    
    twelveButtonArr = [[NSMutableArray alloc ] initWithObjects:_nineClockButton,_tenClockButton,_elevenClockButton,_twelveClockButton,_thirteenClockButton,_forteenClockButton,_fifteenClockButton,_sixteenClockButton,_seventeenClockButton,_eighteenClockButton,_ninteenClockButton,_twentyClockButton, nil];
    
    
    _firstView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _firstView.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    _firstView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstView.layer.masksToBounds = YES;//设为NO去试试

    _secondView.layer.cornerRadius = 0;//设置那个圆角的有多圆
    _secondView.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    _secondView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _secondView.layer.masksToBounds = YES;//设为NO去试试
    
    
    _introLable.layer.cornerRadius = 0;//设置那个圆角的有多圆
    _introLable.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _introLable.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _introLable.layer.masksToBounds = YES;//设为NO去试试
    
    _secondTable.layer.cornerRadius = 0;//设置那个圆角的有多圆
    _secondTable.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _secondTable.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _secondTable.layer.masksToBounds = YES;//设为NO去试试
    
    _headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _headImage.layer.masksToBounds = YES;//设为NO去试试
    
    _lookEvauateButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _lookEvauateButton.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    _lookEvauateButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _lookEvauateButton.layer.masksToBounds = YES;//设为NO去试试
    
    _lookWorksButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _lookWorksButton.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    _lookWorksButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _lookWorksButton.layer.masksToBounds = YES;//设为NO去试试
    
    
    [_secondTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    for (UIButton * _button in twelveButtonArr)//日期按钮全设置未圆角
    {
        _button.layer.cornerRadius = 5;//设置那个圆角的有多圆
        _button.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        _button.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        _button.layer.masksToBounds = YES;//设为NO去试试

    }
    
    
    _sureButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sureButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sureButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sureButton.layer.masksToBounds = YES;//设为NO去试试
    
    _otherSecondView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _otherSecondView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _otherSecondView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _otherSecondView.layer.masksToBounds = YES;//设为NO去试试
    
    _sendBeaspeakButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sendBeaspeakButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sendBeaspeakButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sendBeaspeakButton.layer.masksToBounds = YES;//设为NO去试试
    
    NSString * headStr= [self.inforDic objectForKey:@"head_photo"];
    NSString * nameStr = [self.inforDic objectForKey:@"username"];
    NSString * storeStr = [self.inforDic objectForKey:@"store_name"];
    
    NSString * addressStr = [self.inforDic objectForKey:@"store_address"];
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text=nameStr;
    _cityLable.text = storeStr;
    _addressLable.text = addressStr;
    _worksLable.text=[self.inforDic objectForKey:@"works_num"];
    _evaluateLable.text=[self.inforDic objectForKey:@"assess_num"];
_shalongLable.text=[self.inforDic objectForKey:@"store_name"];
    _telLable.text=[self.inforDic objectForKey:@"mobile"];

    
    
    //新版本年月日
    
    firstTimeLoad = YES;
    self.customPicker.hidden = YES;
    self.toolbarCancelDone.hidden = YES;
    
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (int i = 1; i < 31; i ++)
    {
        NSString *dateStr = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:i * secondsPerDay]];
        NSLog(@"dateString:%@",dateStr);
        [yearArray addObject:dateStr];
    }
    
    NSLog(@"yearArray:%@",yearArray);
    //    NSDate *date = [NSDate date];
    
    // Get Current Year
    
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    // Get Current  Hour
    //    [formatter setDateFormat:@"HH"];
    //    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    //
    //    // Get Current  Minutes
    //    [formatter setDateFormat:@"mm"];
    //    NSString *currentMinutesString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  AM PM
    
    //    [formatter setDateFormat:@"a"];
    //    NSString *currentTimeAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    
    // PickerView -  Hours data
    
    hoursArray = [[NSMutableArray alloc]init];
    for (int i = 9; i <= 22; i++)
    {
        
        [hoursArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }    //    hoursArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    NSLog(@"hoursArray:%@",hoursArray);
    // PickerView -  Hours data
    
    minutesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 59; i=i+15)
    {
        
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    NSLog(@"minutesArray:%@",minutesArray);
    
    // PickerView -  AM PM data
    //    amPmArray=[[NSMutableArray alloc] initWithObjects:@"AM",@"PM", nil];
    //    amPmArray = @[@"AM",@"PM"];
    
    
    
    // PickerView -  days data
    
    
    // PickerView - Default Selection as per current Date
    
    [self.customPicker selectRow:0 inComponent:0 animated:YES];
    
    [self.customPicker selectRow:0 inComponent:1 animated:YES];
    [self.customPicker selectRow:0 inComponent:2 animated:YES];
    //    [self.customPicker selectRow:[amPmArray indexOfObject:currentTimeAMPMString] inComponent:5 animated:YES];


    [self getData];
    [self getData1];
    if(iPhone5)
    {
        
    }
    else{
//        _firstView.hidden=YES;
//
//        _secondView.hidden=YES;
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)getData
{
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=promptView"]]];
    [request setPostValue:[self.inforDic objectForKey:@"uid"]forKey:@"uid"];
    request.tag=1;
    request.delegate=self;
    [request startAsynchronous];
}
-(void)getData1
{
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=goodsView"]]];
    
    [request setPostValue:[self.inforDic objectForKey:@"uid"]forKey:@"uid"];
    request.tag=2;
    request.delegate=self;
    [request startAsynchronous];
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 24, 26);
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
    
    
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = @"预约发型师";
 
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    NSString* cName = [NSString stringWithFormat:@"预约发型师"];
    [MobClick beginLogPageView:cName];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(iPhone5)
    {
        
    }
    else
    {
//        _firstView.hidden=NO;
//        _secondView.hidden=NO;
//        
//        _firstView.frame = CGRectMake(0, 70, 320, 107);
//        _headBackView.frame = CGRectMake(5, 5, 70, 70);
//        _headImage.frame = CGRectMake(5, 5, 60, 60);
//        _nameLable.frame= CGRectMake(96, 20, 108, 20);
//        _cityLable.frame= CGRectMake(96, 45, 108, 20);
////        _lookWorksButton.frame= CGRectMake(227, 12, 86, 22);
////        _lookEvauateButton.frame=CGRectMake(227, 42, 86, 22);
//        _placeLable.frame = CGRectMake(22, 75, 61, 21);
//
//        _addressLable.frame = CGRectMake(85, 70, 242, 30);
//      
//        
//        
//        _secondView.frame = CGRectMake(0, 182, 320, 437);
//
//        _nineClockButton.frame=CGRectMake(0, 160, 80, 30);
//        _tenClockButton.frame=CGRectMake(80, 160, 80, 30);
//        _elevenClockButton.frame=CGRectMake(160, 160, 80, 30);
//        _twelveClockButton.frame=CGRectMake(240, 160, 80, 30);
//        _thirteenClockButton.frame=CGRectMake(0, 190, 80, 30);
//        _forteenClockButton.frame=CGRectMake(80, 190, 80, 30);
//        _fifteenClockButton.frame=CGRectMake(160, 190, 80, 30);
//        _sixteenClockButton.frame=CGRectMake(240, 190, 80, 30);
//        _seventeenClockButton.frame=CGRectMake(0, 220, 80, 30);
//        _eighteenClockButton.frame=CGRectMake(80, 220, 80, 30);
//        _ninteenClockButton.frame=CGRectMake(160, 220, 80, 30);
//        _twentyClockButton.frame=CGRectMake(240, 220, 80, 30);
//
//        _sureButton.frame=CGRectMake(17, 255, 285, 30);
//        
//        
//        _otherSecondView.frame=CGRectMake(0, 190, 320, 244);
    }
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
    
    NSString* cName = [NSString stringWithFormat:@"预约发型师"];
    [MobClick endLogPageView:cName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lookWorksClick:(id)sender {
    
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    scanView.uid=[inforDic objectForKey:@"uid"];
    scanView._hidden = @"no";
    
    scanView.worksOrsaveorCan = @"works";
    
    [self.navigationController pushViewController:scanView animated:NO];
}

- (IBAction)lookEvaluateButtonClick:(id)sender
{
    
    lookEvaluate=nil;
    lookEvaluate = [[lookEvaluateViewController alloc] init];
    lookEvaluate.uid = [inforDic objectForKey:@"uid"];
    lookEvaluate._hidden = @"no";
    
    [self.navigationController pushViewController:lookEvaluate animated:NO];
}

- (IBAction)styleButtonClick:(id)sender {
    UIButton * btn = (UIButton*)sender;
    
    for (UIButton * _button in fourButtonArr) {
        if (_button.tag==btn.tag)
        {
            [_button setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        }
        else
        {
        [_button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        }
    }
    if (btn.tag==1)
    {
        NSString * priceStr = [inforDic objectForKey:@"price_info"];
        NSArray *array = [priceStr componentsSeparatedByString:@"_"];
        
        _oldPrice.text = [NSString stringWithFormat:@"￥%@",[array objectAtIndex:0]];
        NSInteger oldInt= [[array objectAtIndex:0] integerValue];
        float saleInt= [[array objectAtIndex:4] floatValue];
        NSInteger nowInt = oldInt*saleInt/10;
        _nowPrice.text = [NSString stringWithFormat:@"￥%d(%@折)",nowInt,[array objectAtIndex:4]];
        styleString = @"洗剪吹";
        oldPriceString = [array objectAtIndex:0];
        saleString = [array objectAtIndex:4];
    }
    else if (btn.tag==2)
    {
        NSString * priceStr = [inforDic objectForKey:@"price_info"];
        NSArray *array = [priceStr componentsSeparatedByString:@"_"];
        _oldPrice.text = [NSString stringWithFormat:@"￥%@",[array objectAtIndex:1]];
        NSInteger oldInt= [[array objectAtIndex:1] integerValue];
        float saleInt= [[array objectAtIndex:5] floatValue];
        NSInteger nowInt = oldInt*saleInt/10;
        _nowPrice.text = [NSString stringWithFormat:@"￥%d(%@折)",nowInt,[array objectAtIndex:5]];
        styleString = @"烫发";
        oldPriceString = [array objectAtIndex:1];
        saleString = [array objectAtIndex:5];
        
    }

    else if (btn.tag==3)
    {
        NSString * priceStr = [inforDic objectForKey:@"price_info"];
        NSArray *array = [priceStr componentsSeparatedByString:@"_"];
        _oldPrice.text = [NSString stringWithFormat:@"￥%@",[array objectAtIndex:2]];
        NSInteger oldInt= [[array objectAtIndex:2] integerValue];
        float saleInt= [[array objectAtIndex:6] floatValue];
        NSInteger nowInt = oldInt*saleInt/10;
        _nowPrice.text = [NSString stringWithFormat:@"￥%d(%@折)",nowInt,[array objectAtIndex:6]];
        
        styleString = @"染发";
        oldPriceString = [array objectAtIndex:2];
        saleString = [array objectAtIndex:6];
    }
    else if (btn.tag==4)
    {
        NSString * priceStr = [inforDic objectForKey:@"price_info"];
        NSArray *array = [priceStr componentsSeparatedByString:@"_"];
        _oldPrice.text = [NSString stringWithFormat:@"￥%@",[array objectAtIndex:3]];
        NSInteger oldInt= [[array objectAtIndex:3] integerValue];
        float saleInt= [[array objectAtIndex:7] floatValue];
        NSInteger nowInt = oldInt*saleInt/10;
        _nowPrice.text = [NSString stringWithFormat:@"￥%d(%@折)",nowInt,[array objectAtIndex:7]];
        styleString = @"护理";
        oldPriceString = [array objectAtIndex:3];
        saleString = [array objectAtIndex:7];
    }
}

- (IBAction)dateButtonClick:(id)sender {
    
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
     _timeLable.text = [NSString stringWithFormat:@"%@%@",dateString,timeString];
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
    _timeLable.text = [NSString stringWithFormat:@"%@%@",dateString,timeString];
    timeDataString = [NSString stringWithFormat:@"%@ %@",_dayOneLable.text,timeString];
}

- (IBAction)sureButtonClick:(id)sender
{
    if (select==YES) {
        _secondView.hidden=YES;
        _otherSecondView.hidden=NO;
        
        //    _getTimeLable.text = [NSString stringWithFormat:@"%@  %@",dateString,timeString];
        _beaspeakStyleLable.text = [NSString stringWithFormat:@"%@        服务价格:￥%@（%@折）",styleString,newPriceString,saleString];
        
    }
    else
    {
      UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未选择服务项目" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
      [alert show];
    }
   
}
- (IBAction)sendBeaspeakButtonClick:(id)sender
{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
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
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderAdd"]]];
        
        [request setPostValue:@"2"forKey:@"order_type"];//预约发型为2
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        [request setPostValue:appDele.uid forKey:@"my_uid"];
        [request setPostValue:[self.inforDic objectForKey:@"uid"]forKey:@"to_uid"];
        
        [request setPostValue:@"1" forKey:@"order_type"];
        [request setPostValue:styleString forKey:@"reserve_type"];
        
        //        [request setPostValue:dateString1 forKey:@"reserve_time"];
        
        //        [request setPostValue:timeString forKey:@"reserve_hour"];
        
        [request setPostValue:oldPriceString forKey:@"price"];
        [request setPostValue:saleString forKey:@"rebate"];
        [request setPostValue:newPriceString forKey:@"reserve_price"];
        [request setPostValue:[_nameField text] forKey:@"my_name"];
        [request setPostValue:[_mobileField text] forKey:@"my_tel"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        [request setPostValue:_timeField.text forKey:@"reserve_time"];
        [request setPostValue:[inforDic objectForKey:@"work_id"] forKey:@"work_id"];
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"M-d HH:mm"];
//        NSDate* date = [formatter dateFromString:timeDataString];
//         NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
//        NSLog(@"timeDataString:%@",timeDataString);
//        NSLog(@"timeSp:%@",timeSp);
//        
//        [request setPostValue:timeSp forKey:@"expire_time"];
        request.tag=3;
        request.delegate=self;
        [request startAsynchronous];
       
        
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"简介dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            firstArr = [dic objectForKey:@"info"];
//            [_firstTable reloadData];
        }
        else
        {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"您尚有未完成预约" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//            [alert show];
        }

        
    }
    else if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"服务项目dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            secondArr = [dic objectForKey:@"goodsInfo"];
            //            [_firstTable reloadData];
        }
        else
        {
            //            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"您尚有未完成预约" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            //            [alert show];
        }

        [_secondTable reloadData];
        
    }
    else if (request.tag==3) {
        
    
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
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
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"您尚有未完成预约或预约信息出错" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    }

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_firstTable)
    {
        return firstArr.count;
    }
    else
        {
            return secondArr.count+1;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_firstTable)
    {
        return 30;
    }
    else
    {
        return 60;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_firstTable) {
        static NSString *cellID=@"cell";
        UITableViewCell *cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
           
            //            cell.fatherController=self;
        }
        
        NSInteger row =[indexPath row];
        
        cell.textLabel.text = [firstArr objectAtIndex:row];
        
        return cell;
        
    }
    else
    {
        static NSString *cellID=@"cell";
        addBeaspeakViewCell *cell=(addBeaspeakViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[addBeaspeakViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            //            cell.fatherController=self;
        }
        
        NSInteger row =[indexPath row];
        
        if (row==0) {
           
            [cell setFirstCell];
            cell.userInteractionEnabled=NO;
        }
        else
        {
           
            [cell setOtherCell:secondArr and:row];
        }
        
        return cell;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    select =YES;
     NSInteger row =[indexPath row];
    styleString = [[secondArr objectAtIndex:row-1] objectForKey:@"goods_name"];
oldPriceString=[NSString stringWithFormat:@"%@",[[secondArr objectAtIndex:row-1] objectForKey:@"price"]];
    saleString=[NSString stringWithFormat:@"%@",[[secondArr objectAtIndex:row-1] objectForKey:@"rebate"]];
    newPriceString=[NSString stringWithFormat:@"%@",[[secondArr objectAtIndex:row-1] objectForKey:@"reserve_price"]];
    
}

#pragma mark - UIPickerViewDelegate
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//
//    return 3;
//
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    //
    //    if (component == 0)
    //    {
    //        selectedYearRow = row;
    //        [self.customPicker reloadAllComponents];
    //    }
    //    else if (component == 1)
    //    {
    //        selectedMonthRow = row;
    //        [self.customPicker reloadAllComponents];
    //    }
    //    else if (component == 2)
    //    {
    //        selectedDayRow = row;
    //
    //        [self.customPicker reloadAllComponents];
    //
    //    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame;
        if (component == 0)
        {
            frame = CGRectMake(0.0, 0.0, 200, 60);
        }
        else
        {
            frame = CGRectMake(0.0, 0.0, 50, 60);
        }
        
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
        
    }
    //    else if (component == 1)
    //    {
    //        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    //    }
    //    else if (component == 2)
    //    {
    //        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
    //
    //    }
    else if (component == 1)
    {
        pickerLabel.text =  [hoursArray objectAtIndex:row]; // Hours
    }
    else if (component == 2)
    {
        pickerLabel.text =  [minutesArray objectAtIndex:row]; // Mins
    }
    //    else
    //    {
    //        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
    //    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    //    else if (component == 1)
    //    {
    //        return [monthArray count];
    //    }
    //    else if (component == 2)
    //    { // day
    //
    //        if (firstTimeLoad)
    //        {
    //            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
    //            {
    //                return 31;
    //            }
    //            else if (currentMonth == 2)
    //            {
    //                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
    //
    //                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
    //
    //                    return 29;
    //                }
    //                else
    //                {
    //                    return 28; // or return 29
    //                }
    //
    //            }
    //            else
    //            {
    //                return 30;
    //            }
    //
    //        }
    //        else
    //        {
    //
    //            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
    //            {
    //                return 31;
    //            }
    //            else if (selectedMonthRow == 1)
    //            {
    //                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
    //
    //                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
    //                    return 29;
    //                }
    //                else
    //                {
    //                    return 28; // or return 29
    //                }
    //
    //
    //
    //            }
    //            else
    //            {
    //                return 30;
    //            }
    //
    //        }
    //
    //
    //    }
    else if (component == 1)
    { // hour
        
        return 14;
        
    }
    else if (component == 2)
    { // min
        return 4;
    }
    else
    { // am/pm
        return 2;
        
    }
    
    
    
}






- (IBAction)actionCancel:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
}

- (IBAction)actionDone:(id)sender
{
    
    
    _timeField.text = [NSString stringWithFormat:@"%@ %@:%@ ",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[hoursArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[minutesArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
    //    timeDataString=_timeField.text;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_timeField) {
        [self.view endEditing:YES];
        [_mobileField resignFirstResponder];
        [_nameField resignFirstResponder];
    }
    else
    {
        [scrollView adjustOffsetToIdealIfNeeded];
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             self.customPicker.hidden = YES;
                             self.toolbarCancelDone.hidden = YES;
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                         }];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField==_timeField) {
        
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             self.customPicker.hidden = NO;
                             self.toolbarCancelDone.hidden = NO;
                             _timeField.text = @"";
                             
                         }
                         completion:^(BOOL finished){
                             
                         }];
        
        
        self.customPicker.hidden = NO;
        self.toolbarCancelDone.hidden = NO;
        _timeField.text = @"";
        [_mobileField resignFirstResponder];
        [_nameField resignFirstResponder];
        return NO;
        
    }
    
    return YES;
    
    
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}
- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:_nameField];
    [self textFiledReturnEditing:_mobileField];
    
}
@end
