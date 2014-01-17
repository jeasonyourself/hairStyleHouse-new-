//
//  sureStoreViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-16.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "sureStoreViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface sureStoreViewController ()

@end

@implementation sureStoreViewController
@synthesize _hidden;
@synthesize infordic;
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
    _addressText.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _addressText.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _addressText.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _addressText.layer.masksToBounds = YES;//设为NO去试试
    
    _sureButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sureButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sureButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sureButton.layer.masksToBounds = YES;//设为NO去试试
    
    
    _nameField.text=[infordic objectForKey:@"store_name"];
    _mobileField.text=[infordic objectForKey:@"mobile"];
    _addressText.text=[infordic objectForKey:@"city"];
    
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=store_info"]];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:appDele.uid forKey:@"uid"];
//    [request setPostValue:self.orderId forKey:@"order_id"];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"沙龙详情dic:%@",dic);
        
        if ([[dic objectForKey:@"store_info"] isKindOfClass:[NSString class]]) {
            
        }
        else
        {
            _nameField.text =[[dic objectForKey:@"store_info"] objectForKey:@"store_name"];
            _mobileField.text =[[dic objectForKey:@"store_info"] objectForKey:@"telephone"];
            _addressText.text =[[dic objectForKey:@"store_info"] objectForKey:@"store_address"];
            
        }

    }
    if (request.tag==2)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否修改成功dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"认证成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [self leftButtonClick];
        }
    }
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
    [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
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
    Lab.text = @"认证沙龙";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
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

- (IBAction)sureButtonClick:(id)sender
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_mobileField.text];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }

    
     else if ([_mobileField.text isEqualToString:@""]||[_nameField.text isEqualToString:@""]||[_addressText.text isEqualToString:@""]) {
        
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整地认证信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=legalize"]];
    request.delegate=self;
    request.tag=2;
        
        NSLog(@"appDele.uid:%@",appDele.uid);
        NSLog(@"city:%@",appDele.city);
        
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:appDele.city forKey:@"city"];
//        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude] forKey:@"lat"];
//        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude] forKey:@"lng"];
//
    [request setPostValue:_addressText.text forKey:@"store_name"];
    [request setPostValue:_nameField.text forKey:@"address"];
    [request setPostValue:_mobileField.text forKey:@"telephone"];
    [request startAsynchronous];
    }
}


-(IBAction)textFiledReturnEditing:(id)sender
{
    [_nameField resignFirstResponder];
    [_mobileField resignFirstResponder];

}
- (IBAction)touchDown:(id)sender
{
    [_addressText resignFirstResponder];
    [self textFiledReturnEditing:_nameField];
    [self textFiledReturnEditing:_mobileField];

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
