//
//  beaspeakViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "beaspeakViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface beaspeakViewController ()

@end

@implementation beaspeakViewController
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        
        pageCount  = [[NSString alloc] init];
        page=[[NSString alloc] init];
        page = @"1";
        myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    }
    else
    {
    
        pageCount  = [[NSString alloc] init];
        page=[[NSString alloc] init];
        page = @"1";
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320, 40)];
    topImage.backgroundColor = [UIColor whiteColor];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    //    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/2,self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    twoButton.backgroundColor = [UIColor clearColor];
    
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [oneButton setTitle:@"当前预约" forState:UIControlStateNormal];
    [twoButton setTitle:@"历史预约" forState:UIControlStateNormal];
    
    
    
    
    
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];

    
     myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-70) style:UITableViewStylePlain];
    }
    dresserArray =[[NSMutableArray alloc] init];
    inforDic =[[NSMutableDictionary alloc] init];

    nowOrhistory = YES;
    
    //    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    [self getData];
}


#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"预约列表"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"预约列表"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    nowOrhistory = YES;
    [myTableView reloadData];
   
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    nowOrhistory = NO;
    [myTableView reloadData];

    
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

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = @"预约列表";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


-(void)getData
{
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderList&page=%@",page]]];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];

        [request startAsynchronous];
    }
    else
    {
    
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderView"]];
        request.delegate=self;
        request.tag=11;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:@"-1" forKey:@"order_id"];
        [request setPostValue:appDele.secret forKey:@"secret"];

        [request startAsynchronous];

        
         ASIFormDataRequest* request1=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderList&page=%@",page]]];
        request1.delegate=self;
        request1.tag=1;//发型师查看列表历史页
        [request1 setPostValue:appDele.uid forKey:@"uid"];
        [request1 setPostValue:appDele.secret forKey:@"secret"];

        [request1 startAsynchronous];
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
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约列表dic:%@",dic);
        
        pageCount=[dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"orderList"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"orderList"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"orderList"];
            
        }
        [self freashView];
    }
    
    if (request.tag==11)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"当前预约dic:%@",dic);
        
        if ([[dic objectForKey:@"orderInfo"] isKindOfClass:[NSString class]])
        {
            
        }
        else
        {
            inforDic = [dic objectForKey:@"orderInfo"];
            [self freashView];
            
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
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        myTableView.allowsSelection=YES;

        return dresserArray.count;
    }
    else
    {
        if (nowOrhistory==YES)//当前预约
        {
            myTableView.allowsSelection=NO;
            
            
            
            return 1;
        }
        else
        {
            myTableView.allowsSelection=YES;

            
            NSLog(@"dresserArray.count:%d",dresserArray.count);
        return dresserArray.count;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        return 100;
    }
    else
    {
        if (nowOrhistory==YES)//当前预约
        {
            if ([[inforDic objectForKey:@"order_type"] isEqualToString:@"1"]) {
                return myTableView.frame.size.height;
            }
            else
            {
            return myTableView.frame.size.height+200;
            }
            
            
        }
        else
            
        {
            return 100;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if ([dresserOrCommen isEqualToString:@"dresser"])
     
{
    static NSString *cellID=@"cell";
    beaspeakCell *cell=(beaspeakCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[beaspeakCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger row =[indexPath row];
   
        [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
      return cell;
}
    else
        
    {
        static NSString *cellID=@"cell";
        beaspeakCellAgain *cell=(beaspeakCellAgain *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            cell=[[beaspeakCellAgain alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.fatherView=self;
        }

        if (nowOrhistory==YES)
        {
            
            
            NSInteger row =[indexPath row];
            [cell setCell1:inforDic andIndex:row];
            
            return cell;
        }
        else
            
        {
            NSInteger row =[indexPath row];
            [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
            return cell;
 
        }
        
    }
    
    
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dresserOrCommen isEqualToString:@"dresser"]) {
        deaspeakDresser =nil;
        deaspeakDresser =[[beaspeakDresserViewController alloc] init];
        deaspeakDresser.dresserOrCommen = @"dresser";
        deaspeakDresser.orderId = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"id"];
        NSLog(@"orderId:%@",deaspeakDresser.orderId);
        
        [self.navigationController pushViewController:deaspeakDresser animated:NO];
    }
    else
    {
        if (nowOrhistory==YES)//当前预约
        {
            
        }
        else
        {
            deaspeakDresser =nil;
            deaspeakDresser =[[beaspeakDresserViewController alloc] init];
            deaspeakDresser.orderId = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"id"];
            [self.navigationController pushViewController:deaspeakDresser animated:NO];
        }
    }
    
    
}

-(void)pushDresserView:(NSString*)str
{
    dreserView =nil;
    dreserView =[[dresserInforViewController alloc] init];
    dreserView.uid = str;
    [self.navigationController pushViewController:dreserView animated:NO];
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    [ appDele pushToViewController:dreserView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
