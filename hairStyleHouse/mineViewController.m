//
//  mineViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "mineViewController.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"

#import "MobClick.h"
@interface mineViewController ()

@end

@implementation mineViewController
@synthesize freash;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
        Lab.text = @"个人中心";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    inforDic = [[NSDictionary alloc] init];
    userInfor = [[NSMutableDictionary alloc] init];
   userInforArr = [[NSMutableArray alloc] init];

    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    self.freash=@"yes";
    [self refreashNav];
//    [self getData];
   
	// Do any additional setup after loading the view.
}

-(void)leftButtonClick
{
    
}
-(void)rightButtonClick
{
    pubImage = nil;
    pubImage = [[pubImageViewController alloc] init];
    pubImage._hidden=@"yes";
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([appDele.type isEqualToString:@"2"]) {
        pubImage.dresserOrComment = @"dresser";
    }
    else
    {
    pubImage.dresserOrComment = @"comment";
    }
    [appDele pushToViewController:pubImage];

}

-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"个人中心"];
    [MobClick beginLogPageView:cName];
//    [loginView.view removeFromSuperview];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSLog(@"appDele.uid:%@",appDele.uid);
    
    if (!appDele.uid) {
        loginView = nil;
        loginView=[[loginViewController alloc] init];
        loginView._leftButtonhidden = @"yes";
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        loginView.view.userInteractionEnabled=YES;
//        [self.view addSubview:loginView.view];
        [self.navigationController pushViewController:loginView animated:NO];
        
        
    }
    else
    {
        [self getData];
    }

//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    NSLog(@"appDele.uid:%@",appDele.uid);
//    
//    if (!appDele.uid) {
//        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
////        loginView.userInteractionEnabled=YES;
////        [self.view addSubview:loginView];
//        [self.navigationController pushViewController:loginView animated:YES];
//    }
//    else
//    {
//        [self getData];
//    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"个人中心"];
    [MobClick endLogPageView:cName];
}


-(void)getData
{

//    if ([appDele.type isEqualToString:@"1"]) {
//        ASIHTTPRequest* request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=info&type=%@&uid=%@",appDele.type,appDele.uid]]];
//        request.delegate=self;
//        request.tag=1;
//        [request startAsynchronous];
//    }
//    else
//    {
//        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=info"]]];
//        request.delegate=self;
//        request.tag=1;
//        [request setPostValue:appDele.uid forKey:@"uid"];
//        [request setPostValue:appDele.type forKey:@"type"];
//        [request startAsynchronous];
//    }
    
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=info"]];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    request.delegate=self;
    [request setPostValue:appDele.uid forKey:@"to_uid"];
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:appDele.type forKey:@"type"];
    [request setPostValue:appDele.secret forKey:@"secret"];
    //    [request setPostValue:@"" forKey:@"sina_keyid"];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    NSData*jsondata = [request responseData];
    NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSLog(@"个人信息dic:%@",dic);
    inforDic = [dic objectForKey:@"user_info"];
    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:[inforDic objectForKey:@"type"] forKey:@"type"];
    
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    //        NSLog(@"path = %@",path);
    NSString * plistString = [NSString stringWithFormat:@"userInfor"];
    NSString *filename=[path stringByAppendingPathComponent:plistString];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    if (!dataArray)
    {
        //1. 创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    else
    {
        userInfor=[dataArray objectAtIndex:0];
        
        if ([[inforDic objectForKey:@"type"] isEqualToString:@"1"])//普通用户
        {
            if (![userInfor objectForKey:@"name"])
                  {
                      [userInfor setObject:[inforDic objectForKey:@"username"] forKey:@"name"];
                      [userInfor setObject:[inforDic objectForKey:@"head_photo"] forKey:@"head_photo"];
                      [userInfor setObject:[inforDic objectForKey:@"city"] forKey:@"city"];
                      [userInfor setObject:[inforDic objectForKey:@"fans_num"] forKey:@"fans_num"];
                      [userInfor setObject:[inforDic objectForKey:@"attention_num"] forKey:@"attention_num"];
                      
                      
                      [userInforArr addObject:userInfor];
                      [userInforArr writeToFile:filename atomically:YES];
                      
                      [self refreashNav];
                      [self freashView];
                  }
            
            else if (![[userInfor objectForKey:@"name"]isEqualToString:[inforDic objectForKey:@"username"]]||![[userInfor objectForKey:@"head_photo"]isEqualToString:[inforDic objectForKey:@"head_photo"]]||![[userInfor objectForKey:@"city"]isEqualToString:[inforDic objectForKey:@"city"]]||![[userInfor objectForKey:@"fans_num"]isEqualToString:[inforDic objectForKey:@"fans_num"]]||![[userInfor objectForKey:@"attention_num"]isEqualToString:[inforDic objectForKey:@"attention_num"]])
            {
                userInforArr1=nil;
                userInforArr1 = [[NSMutableArray alloc] init];

                [userInfor setObject:[inforDic objectForKey:@"username"] forKey:@"name"];
                [userInfor setObject:[inforDic objectForKey:@"head_photo"] forKey:@"head_photo"];
                [userInfor setObject:[inforDic objectForKey:@"city"] forKey:@"city"];
                [userInfor setObject:[inforDic objectForKey:@"fans_num"] forKey:@"fans_num"];
                [userInfor setObject:[inforDic objectForKey:@"attention_num"] forKey:@"attention_num"];
                
                
                [userInforArr1 addObject:userInfor];
                [userInforArr1 writeToFile:filename atomically:YES];
                
                
                [self freashView];
            }
            else
            {
                if ([freash isEqualToString:@"yes"]) {
                    [self freashView];
                    self.freash=@"no";

                }
                else
                {
                
                }
            }
            
        }
        else//发型师
        {
            NSLog(@"userInfor:%@",userInfor);

            if (![userInfor objectForKey:@"name"])
            {
                [userInfor setObject:[inforDic objectForKey:@"username"] forKey:@"name"];
                [userInfor setObject:[inforDic objectForKey:@"head_photo"] forKey:@"head_photo"];
                [userInfor setObject:[inforDic objectForKey:@"city"] forKey:@"city"];
                [userInfor setObject:[inforDic objectForKey:@"fans_num"] forKey:@"fans_num"];
                [userInfor setObject:[inforDic objectForKey:@"attention_num"] forKey:@"attention_num"];
                [userInfor setObject:[inforDic objectForKey:@"collect_num"] forKey:@"collect_num"];
                [userInfor setObject:[inforDic objectForKey:@"assess_num"] forKey:@"assess_num"];
                [userInforArr addObject:userInfor];
                [userInforArr writeToFile:filename atomically:YES];
                
                [self freashView];
            }
            
            
           else if (![[userInfor objectForKey:@"name"]isEqualToString:[inforDic objectForKey:@"username"]]||![[userInfor objectForKey:@"head_photo"]isEqualToString:[inforDic objectForKey:@"head_photo"]]||![[userInfor objectForKey:@"city"]isEqualToString:[inforDic objectForKey:@"city"]]||![[userInfor objectForKey:@"fans_num"]isEqualToString:[inforDic objectForKey:@"fans_num"]]||![[userInfor objectForKey:@"attention_num"]isEqualToString:[inforDic objectForKey:@"attention_num"]]||![[userInfor objectForKey:@"collect_num"]isEqualToString:[inforDic objectForKey:@"collect_num"]]||![[userInfor objectForKey:@"assess_num"]isEqualToString:[inforDic objectForKey:@"assess_num"]])
            {
                userInforArr1=nil;
                userInforArr1 = [[NSMutableArray alloc] init];

                [userInfor setObject:[inforDic objectForKey:@"username"] forKey:@"name"];
                [userInfor setObject:[inforDic objectForKey:@"head_photo"] forKey:@"head_photo"];
                [userInfor setObject:[inforDic objectForKey:@"city"] forKey:@"city"];
                [userInfor setObject:[inforDic objectForKey:@"fans_num"] forKey:@"fans_num"];
                [userInfor setObject:[inforDic objectForKey:@"attention_num"] forKey:@"attention_num"];
                [userInfor setObject:[inforDic objectForKey:@"collect_num"] forKey:@"collect_num"];
                [userInfor setObject:[inforDic objectForKey:@"assess_num"] forKey:@"assess_num"];
                [userInforArr1 addObject:userInfor];
                [userInforArr1 writeToFile:filename atomically:YES];
                
                [self freashView];
            }
            else
            {
                
                if ([freash isEqualToString:@"yes"]) {
                    [self freashView];
                    self.freash=@"no";
                    
                }
                else
                {
                    
                }
                
            }
            
        }
 
   //    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
}
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:0.0];
    [leftButton.layer setBorderWidth:0.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, 0, 0);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
    UIButton * rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    rightButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    rightButton.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    rightButton.layer.masksToBounds = YES;//设为NO去试试
    [rightButton setTitle:@"上传图片" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)freashView
{
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([appDele.type isEqualToString:@"1"])
    {
        return   self.view.frame.size.height;

    }
    else if ([appDele.type isEqualToString:@"2"])
    {
        return   self.view.frame.size.height+12;

    }
    else
        
    {
    return   self.view.frame.size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [self updateBackView];
//    backView.view.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([appDele.type isEqualToString:@"1"])
    {
        [cell.contentView addSubview:backView.view];

    }
    else if ([appDele.type isEqualToString:@"2"])
    {
        [cell.contentView addSubview:backView1.view];

    }
    return cell;
}

- (void)updateBackView
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([appDele.type isEqualToString:@"1"])
    {
        
        backView=nil;
        backView=[[singleTableCellBackgroundViewController alloc] init];
        backView.fatherController=self;
        backView.infoDic =inforDic;

    }
    else if ([appDele.type isEqualToString:@"2"])
    {
        backView1=nil;
        backView1=[[renewSingleTableCellBackgroundViewController alloc] init];
        backView1.fatherController=self;
        backView1.infoDic =inforDic;
        
    }
   }
-(void)pushToViewController:(id)_sen
{
    [self.navigationController pushViewController:_sen animated:NO];
}
-(void)needAppdelegatePushToViewController:(id)_sen
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [appDele pushToViewController:_sen];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
