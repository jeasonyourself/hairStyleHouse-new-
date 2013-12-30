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
@interface mineViewController ()

@end

@implementation mineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
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
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    
   
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
    [appDele pushToViewController:pubImage];

}

-(void)viewDidAppear:(BOOL)animated
{
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
        [self.navigationController pushViewController:loginView animated:YES];
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


-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

//    if ([appDele.type isEqualToString:@"1"]) {
        ASIHTTPRequest* request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=info&type=%@&uid=%@",appDele.type,appDele.uid]]];
        request.delegate=self;
        request.tag=1;
        [request startAsynchronous];
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
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    NSData*jsondata = [request responseData];
    NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSLog(@"个人信息dic:%@",dic);
    inforDic = [dic objectForKey:@"user_info"];
    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:[inforDic objectForKey:@"type"] forKey:@"type"];
    
    [self refreashNav];
    [self freashView];
//    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)refreashNav
{
    
    UIButton * rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton.layer setMasksToBounds:YES];
    [rightButton.layer setCornerRadius:3.0];
    [rightButton.layer setBorderWidth:1.0];
    [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [rightButton setTitle:@"上传图片" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rightButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
        return   self.view.frame.size.height+120;

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
