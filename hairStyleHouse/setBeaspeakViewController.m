//
//  setBeaspeakViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-20.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "setBeaspeakViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"
@interface setBeaspeakViewController ()

@end

@implementation setBeaspeakViewController
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
    [super viewDidLoad];
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"预约设置";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    
    dresserArray = [[NSMutableArray alloc] init];
    
    _firstPrice.keyboardType=UIKeyboardTypeDecimalPad;
    _secondPrice.keyboardType=UIKeyboardTypeDecimalPad;
    _thirdPrice.keyboardType=UIKeyboardTypeDecimalPad;
    _forthPrice.keyboardType=UIKeyboardTypeDecimalPad;
    _firstSale.keyboardType=UIKeyboardTypeDecimalPad;
    _secondSale.keyboardType=UIKeyboardTypeDecimalPad;
    _thirdSale.keyboardType=UIKeyboardTypeDecimalPad;
    _forthSale.keyboardType=UIKeyboardTypeDecimalPad;

    
    
    _sureButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sureButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sureButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sureButton.layer.masksToBounds = YES;//设为NO去试试
    
    [self getData];
    // Do any additional setup after loading the view from its nib.
}
-(void)getData
{
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=notice_show"]];
    request.delegate=self;
    request.tag=101;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request startAsynchronous];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    
    
    
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
    
    if ([_firstTextField isFirstResponder]||[_secondTextField isFirstResponder]||[_thirdTextField isFirstResponder]||[_forthTextField isFirstResponder]||[_fifithTextField isFirstResponder]) {
        
    }
    else
    {
    _backView.frame = newTextViewFrame;
    }
    NSLog(@"_backView.frame:%@",NSStringFromCGRect(self.view.frame));
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    if ([_hidden isEqualToString:@"yes"])
    {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)sureButtonClick:(id)sender
{
    if ([_firstTextField.text isEqualToString:@""]&&[_secondTextField.text isEqualToString:@""]&&[_thirdTextField.text isEqualToString:@""]&&[_forthTextField.text isEqualToString:@""]&&[_fifithTextField.text isEqualToString:@""])
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入至少一个提醒设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([_firstPrice.text isEqualToString:@""]||[_firstSale.text isEqualToString:@""]||[_secondPrice.text isEqualToString:@""]||[_secondSale.text isEqualToString:@""]||[_thirdPrice.text isEqualToString:@""]||[_thirdSale.text isEqualToString:@""]||[_forthPrice.text isEqualToString:@""]||[_forthSale.text isEqualToString:@""])
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整的价格和折扣信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=notice"]];
        request.delegate=self;
            request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        if (![_firstTextField.text isEqualToString:@""]) {
            [request setPostValue:_firstTextField.text forKey:@"tip1"];

        }
        if (![_secondTextField.text isEqualToString:@""]) {
            [request setPostValue:_secondTextField.text forKey:@"tip2"];
            
        }
        if (![_thirdTextField.text isEqualToString:@""]) {
            [request setPostValue:_thirdTextField.text forKey:@"tip3"];
            
        }
        if (![_forthTextField.text isEqualToString:@""]) {
            [request setPostValue:_forthTextField.text forKey:@"tip4"];
            
        }
        if (![_fifithTextField.text isEqualToString:@""]) {
            [request setPostValue:_fifithTextField.text forKey:@"tip5"];
            
        }
        
        [request startAsynchronous];
    }
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约提醒dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
            
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=priceset"]];
            request.delegate=self;
            request.tag=2;
            [request setPostValue:appDele.uid forKey:@"uid"];
            
            NSString * priceStr = [NSString stringWithFormat:@"%@_%@_%@_%@_%@_%@_%@_%@",_firstPrice.text,_secondPrice.text,_thirdPrice.text,_forthPrice.text,_firstSale.text,_secondSale.text,_thirdSale.text,_forthSale.text];
            [request setPostValue:priceStr forKey:@"price_info"];

            [request startAsynchronous];
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }

    }
    if(request.tag==2)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约提醒dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
            
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self leftButtonClick];
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }    }
    
    if (request.tag==101) {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约提醒dic:%@",dic);
        if ([[[dic objectForKey:@"notice_info"] objectForKey:@"info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[[dic objectForKey:@"notice_info"] objectForKey:@"info"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [[dic objectForKey:@"notice_info"] objectForKey:@"info"];
            
        }

        if (dresserArray.count==1) {
            _firstTextField.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0] ];
            
        }
        else if (dresserArray.count==2) {
            _firstTextField.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
            
            
        }
        else if (dresserArray.count==3) {
            _firstTextField.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
            _thirdTextField.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
        }
        else if (dresserArray.count==4) {
            _firstTextField.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
            _thirdTextField.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
            _forthTextField.text= [NSString stringWithFormat:@"4、%@",[dresserArray objectAtIndex:3]];
        }
        else if (dresserArray.count==5) {
            
            _firstTextField.text = [NSString stringWithFormat:@"1、%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"2、%@",[dresserArray objectAtIndex:1]];
            _thirdTextField.text= [NSString stringWithFormat:@"3、%@",[dresserArray objectAtIndex:2]];
            _forthTextField.text= [NSString stringWithFormat:@"4、%@",[dresserArray objectAtIndex:3]];
            _fifithTextField.text= [NSString stringWithFormat:@"5、%@",[dresserArray objectAtIndex:4]];
        }
        else if (dresserArray.count==0)
        {
            
        }
        
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=priceinfo"]];
        request.delegate=self;
        request.tag=102;
        [request setPostValue:appDele.uid forKey:@"uid"];
        
        [request startAsynchronous];
    }
    
    if (request.tag==102) {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"价格详情dic:%@",dic);
        NSString * priceStr = [dic objectForKey:@"price_info"];
        NSArray *array = [priceStr componentsSeparatedByString:@"_"];
        
        
        _firstPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        _firstSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
       
        
        _secondPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
        _secondSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
        _thirdPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        _thirdSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:6]];
        _forthPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
        _forthSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:7]];
       

    }
       //    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:_firstTextField];
    [self textFiledReturnEditing:_secondTextField];
    [self textFiledReturnEditing:_thirdTextField];
    [self textFiledReturnEditing:_forthTextField];
    [self textFiledReturnEditing:_fifithTextField];

    [self textFiledReturnEditing:_firstPrice];
    [self textFiledReturnEditing:_secondPrice];
    [self textFiledReturnEditing:_thirdPrice];
    [self textFiledReturnEditing:_forthPrice];

    
    [self textFiledReturnEditing:_firstSale];
    [self textFiledReturnEditing:_secondSale];
    [self textFiledReturnEditing:_thirdSale];
    [self textFiledReturnEditing:_forthSale];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
