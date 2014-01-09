//
//  fansAndFouceAndmassegeViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "fansAndFouceAndmassegeViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface fansAndFouceAndmassegeViewController ()

@end

@implementation fansAndFouceAndmassegeViewController
@synthesize fansOrFouce;
@synthesize fansOrFouceOrMessage;

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

    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
         myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    }
    else
    {
        topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
        [topImage setImage:[UIImage imageNamed:@"1发型师.png"]];
        
        UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 160, 50);
        oneButton.backgroundColor = [UIColor clearColor];
        [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        twoButton.frame = CGRectMake(160,self.navigationController.navigationBar.frame.size.height+20, 160, 50);
        twoButton.backgroundColor = [UIColor clearColor];
        [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topImage];
        [self.view addSubview:oneButton];
        [self.view addSubview:twoButton];
        
         myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStylePlain];
        
    }

   

    dresserOrperson =YES;
    dresserArray =[[NSMutableArray alloc] init];
    
   
//    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    
    [self getData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)oneButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"1发型师.png"]];
    dresserOrperson =YES;
    [self getData];

}
-(void)twoButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"2个人用户.png"]];
    dresserOrperson =NO;
    [self getData];
}

-(void)leftButtonClick
{
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:NO];
    
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
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        Lab.text = @"消息记录";
    }
    else
    {
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            Lab.text = @"我的粉丝";
        }
        else
        {
            Lab.text = @"我的关注";
        }
        
    }
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


-(void)getData
{
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Message&a=index"]];
        request.delegate=self;
        request.tag=2;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request startAsynchronous];
        
    }
    else
    {
        NSURL * urlString;
        if ([fansOrFouce isEqualToString:@"fans"])
        {
            urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=fanlist"];

        }
        else
        {
           urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=watchlist"];
        }
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        if (dresserOrperson==YES)
        {
            [request setPostValue:@"2" forKey:@"type"];
            
        }
        else
        {
            [request setPostValue:@"1" forKey:@"type"];
            
        }
        [request startAsynchronous];
    }

    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (dresserArray!=nil) {
        [dresserArray removeAllObjects];
    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"粉丝列表dic:%@",dic);
        if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"user_info"];

        }
        [self freashView];
    }
    if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"消息表dic:%@",dic);
        if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"message_list"];
            
        }
        [self freashView];
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
    return dresserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    fansAndfoceAndMassegeCell *cell=(fansAndfoceAndMassegeCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[fansAndfoceAndMassegeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger row =[indexPath row];
    if ([fansOrFouceOrMessage isEqualToString:@"massege"])
    {
        [cell setCell2:[dresserArray objectAtIndex:row] andIndex:row];
    }
    else
    {
    [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([fansOrFouceOrMessage isEqualToString:@"massege"]) {

        talkView=nil;
        talkView = [[talkViewController alloc] init];
        talkView.uid = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"uid"];
        [self.navigationController pushViewController:talkView animated:NO];
        
    }
    else
    {
        if (dresserOrperson==YES)
        {
            //查看发型师
            dreserView =nil;
            dreserView =[[dresserInforViewController alloc] init];
            dreserView.uid = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"uid"];
            dreserView._hidden=@"no";
            [self.navigationController pushViewController:dreserView animated:NO];
        }
        else
        {
            //查看个人
            
            userView =nil;
            userView =[[userInforViewController alloc] init];
            userView.uid = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"uid"];
            userView._hidden=@"no";
            [self.navigationController pushViewController:userView animated:NO];
        }
    
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
