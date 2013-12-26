//
//  dresserViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "AllAroundPullView.h"
@interface dresserViewController ()

@end

@implementation dresserViewController
@synthesize fromFouceLoginCancel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = @"发型师";
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
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setImage:[UIImage imageNamed:@"全部.png"]];
    
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(80,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(160,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * forthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forthButton.frame = CGRectMake(240,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    forthButton.backgroundColor = [UIColor clearColor];
    [forthButton addTarget:self action:@selector(forthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    [self.view addSubview:forthButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    dresserArray1 =[[NSMutableArray alloc] init];
    dresserArray2 =[[NSMutableArray alloc] init];
    dresserArray3 =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page1 =[[NSString alloc] init];
    page2 =[[NSString alloc] init];
    page3 =[[NSString alloc] init];
    page=@"1";
    page1=@"1";
    page2=@"1";
    page3=@"1";
    pageCount=[[NSString alloc] init];
    pageCount1=[[NSString alloc] init];
    pageCount2=[[NSString alloc] init];
    pageCount3=[[NSString alloc] init];

    sign =[[NSString alloc] init];
    fromFouceLoginCancel=[[NSString alloc] init];
    sign = @"all";
    fromFouceLoginCancel=@"all";
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (appDele.uid)
    {
    [self getData];
    [self getData1];
    [self getData2];
    [self getData3];
    }
    else
    {
        [self getData];
        [self getData1];
        [self getData2];
    }
}

-(void)pullLoadMore
{
        if ([sign isEqualToString:@"all"])
        {
            NSInteger _pageCount= [pageCount integerValue];

           NSInteger _page = [page integerValue];
            if (_page<_pageCount) {
                _page++;
                page = [NSString stringWithFormat:@"%d",_page];
                NSLog(@"page:%@",page);
                [self getData];
            }
            else
            {
                [bottomRefreshView performSelector:@selector(finishedLoading)];
                
            }

        }
        else if([sign isEqualToString:@"sameCity"])
        {
            NSInteger _pageCount1= [pageCount1 integerValue];

            NSInteger _page = [page1 integerValue];
            if (_page<_pageCount1) {
                _page++;
                page1 = [NSString stringWithFormat:@"%d",_page];
                NSLog(@"page1:%@",page1);
                [self getData1];
            }
            else
            {
                [bottomRefreshView performSelector:@selector(finishedLoading)];
                
            }


        }
        else if([sign isEqualToString:@"introduce"])
        {
            NSInteger _pageCount2= [pageCount2 integerValue];

            NSInteger _page = [page2 integerValue];
            if (_page<_pageCount2) {
                _page++;
                page2 = [NSString stringWithFormat:@"%d",_page];
                NSLog(@"page:%@",page2);
                [self getData2];
            }
            else
            {
                [bottomRefreshView performSelector:@selector(finishedLoading)];
                
            }

        }
        else if([sign isEqualToString:@"fouce"])
        {
            NSInteger _pageCount3= [pageCount3 integerValue];

            NSInteger _page = [page3 integerValue];
            if (_page<_pageCount3) {
                _page++;
                page3 = [NSString stringWithFormat:@"%d",_page];
                NSLog(@"page:%@",page3);
                [self getData3];
            }
            else
            {
                [bottomRefreshView performSelector:@selector(finishedLoading)];
                
            }

        }
}

-(void)viewDidAppear:(BOOL)animated
{
  
}

-(void)oneButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"全部.png"]];
//    [requestMain clearDelegatesAndCancel];
    sign =@"all";
    fromFouceLoginCancel=@"all";
    [myTableView reloadData];
//    page=@"1";
////    [dresserArray removeAllObjects];
//    [self getData];
    
}
-(void)twoButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"同城1.png"]];
//    [requestMain clearDelegatesAndCancel];

    sign =@"sameCity";
    fromFouceLoginCancel=@"sameCity";
    [myTableView reloadData];

//    page1=@"1";
////    [dresserArray1 removeAllObjects];
//    [self getData1];
}
-(void)thirdButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"推荐.png"]];
//    [requestMain clearDelegatesAndCancel];

    sign =@"introduce";
    fromFouceLoginCancel=@"introduce";
    [myTableView reloadData];

//    page2=@"1";
////    [dresserArray2 removeAllObjects];
//    [self getData2];
    
}
-(void)forthButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"4关注.png"]];
//    [requestMain clearDelegatesAndCancel];

    sign =@"fouce";
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if (appDele.uid)
    {
        [myTableView reloadData];

    }
    else
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"yes";
        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getDataback2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
        
    }

//    page3=@"1";
////    [dresserArray3 removeAllObjects];
//    [self getData3];
    
}
-(void)fromFouceCancelBack:(NSString *)_str
{
    
    if ([fromFouceLoginCancel isEqualToString:@"all"]) {
        [self oneButtonClick];
    }
    else if ([fromFouceLoginCancel isEqualToString:@"sameCity"])
    {
        [self twoButtonClick];
    }
    else if ([fromFouceLoginCancel isEqualToString:@"introduce"])
    {
        [self thirdButtonClick];
    }
//    NSLog(@"fromFouceLoginCancel:%@",fromFouceLoginCancel);
//    sign=_str;
//    page=@"1";
//    if ([fromFouceLoginCancel isEqualToString:@"all"]) {
//        
//        [topImage setImage:[UIImage imageNamed:@"全部.png"]];
//        [self getDataback];
//        
//    }
//    else if ([fromFouceLoginCancel isEqualToString:@"sameCity"])
//    {
//        [topImage setImage:[UIImage imageNamed:@"同城1.png"]];
//        [self getDataback];
//    }
//    else if ([fromFouceLoginCancel isEqualToString:@"introduce"])
//    {
//        [topImage setImage:[UIImage imageNamed:@"推荐.png"]];
//        
//        [self getDataback];
//    }
    
   
}

-(void)getDataback
{
    [dresserArray removeAllObjects];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    
    if ([fromFouceLoginCancel isEqualToString:@"all"])
    {
        //            page=@"2";
        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=allstylists&page=%@",page]]];
    }
    else if([fromFouceLoginCancel isEqualToString:@"sameCity"])
    {
        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=citystylists&page=%@",page]]];
        [requestMain setPostValue:appDele.city forKey:@"city"];
        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ]forKey:@"lng"];
        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
    }
    else if([fromFouceLoginCancel isEqualToString:@"introduce"])
    {
        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=recomstylists&page=%@",page]]];
    }
    requestMain.delegate=self;
    requestMain.tag=1;
    
    if (appDele.uid) {
        [requestMain setPostValue:appDele.uid forKey:@"uid"];
    }
    else
    {
        
    }
    [requestMain startAsynchronous];
    //    }
    
}

-(void)getDataback2
{
    [self getData3];
//    page=@"1";
//    [dresserArray removeAllObjects];
//    page1=@"1";
//    [dresserArray1 removeAllObjects];
//    page2=@"1";
//    [dresserArray2 removeAllObjects];
//    page3=@"1";
//    [dresserArray3 removeAllObjects];
//    [self getData];
}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=allstylists&page=%@",page]]];
        requestMain.delegate=self;
        requestMain.tag=100;
        
        if (appDele.uid) {
            [requestMain setPostValue:appDele.uid forKey:@"uid"];
        }
        else
        {
            
        }
        [requestMain startAsynchronous];
  
}

-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
            requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=citystylists&page=%@",page1]]];
        [requestMain setPostValue:appDele.city forKey:@"city"];
        NSLog(@"city:%@",appDele.city);
        
        NSLog(@"%f",appDele.longitude);
        NSLog(@"%f",appDele.latitude);
        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ]forKey:@"lng"];
        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
        requestMain.delegate=self;
        requestMain.tag=101;
        
        if (appDele.uid) {
            [requestMain setPostValue:appDele.uid forKey:@"uid"];
        }
        else
        {
            
        }
        [requestMain startAsynchronous];
    
}

-(void)getData2
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=recomstylists&page=%@",page2]]];
        requestMain.delegate=self;
        requestMain.tag=102;
        
        if (appDele.uid) {
            [requestMain setPostValue:appDele.uid forKey:@"uid"];
        }
        else
        {
            
        }
        [requestMain startAsynchronous];
    
}

-(void)getData3
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
   
        NSLog(@"appDele.uid:%@",appDele.uid);
        
      
            requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=followstylists&page=%@",page3]]];
            requestMain.delegate=self;
            requestMain.tag=103;
            
            if (appDele.uid)
            {
                [requestMain setPostValue:appDele.uid forKey:@"uid"];
            }
            else
            {
                
            }
            [requestMain startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray * arr;
//    if (dresserArray!=nil) {
//        arr= [NSMutableArray arrayWithArray:dresserArray];
//        [dresserArray removeAllObjects];
//    }
    if (request.tag==100) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师dic:%@",dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        
            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"user_info"];
                [dresserArray addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray.count);
            
            }
        [self freashView];

        }
    else if (request.tag==101)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师dic:%@",dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        
            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"user_info"];
                [dresserArray1 addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray1.count);
                
            }
[self freashView];
        
    }
    else if (request.tag==102)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);

        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师dic:%@",dic);
        
        pageCount2 = [dic objectForKey:@"page_count"];
    
            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"user_info"];
                [dresserArray2 addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray2.count);
                
            }
[self freashView];
    }
    else if (request.tag==103)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师dic:%@",dic);
        
        pageCount3 = [dic objectForKey:@"page_count"];
        
            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"user_info"];
                [dresserArray3 addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray3.count);
                
            }
        [self freashView];

    }
    if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否关注成功dic:%@",dic);
        
        [myTableView reloadData];
        //            if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSString class]])
        //            {
        //
        //            }
        //            else if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSArray class]])
        //            {
        //                dresserArray = [dic objectForKey:@"message_list"];
        //
        //            }
        
//        [self getData];
    }
    
}
-(void)freashView
{
    [bottomRefreshView performSelector:@selector(finishedLoading)];
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([sign isEqualToString:@"all"])
    {
        return dresserArray.count;

    }
    else if([sign isEqualToString:@"sameCity"])
    {
        return dresserArray1.count;

    }
    else if([sign isEqualToString:@"introduce"])
    {
        return dresserArray2.count;

    }
    else if([sign isEqualToString:@"fouce"])
    {
        return dresserArray3.count;

    }
    return dresserArray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_content;
    if ([sign isEqualToString:@"all"])
    {
        _content =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
        
    }
    else if([sign isEqualToString:@"sameCity"])
    {
        _content =[[dresserArray1 objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
        
    }
    else if([sign isEqualToString:@"introduce"])
    {
        _content =[[dresserArray2 objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
        
    }
    else if([sign isEqualToString:@"fouce"])
    {
        _content =[[dresserArray3 objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
        
    }

    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(260,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    if ([_content isEqualToString:@""]) {
        return   80;
    }
    else
    {
        return 80+labelsize.height;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    dresserCell *cell=(dresserCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[dresserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherController=self;
    }
    
    NSInteger row =[indexPath row];
    if ([sign isEqualToString:@"all"])
    {
        [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
        
    }
    else if([sign isEqualToString:@"sameCity"])
    {
        [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];
        
    }
    else if([sign isEqualToString:@"introduce"])
    {
        [cell setCell:[dresserArray2 objectAtIndex:row] andIndex:row];
        
    }
    else if([sign isEqualToString:@"fouce"])
    {
        [cell setCell:[dresserArray3 objectAtIndex:row] andIndex:row];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //查看发型师
    
    
}

-(void)selectCell:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView._hidden=@"yes";
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getDataback2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        [appDele pushToViewController:loginView ];
    }
    else
    {

        dreserView =nil;
        dreserView =[[dresserInforViewController alloc] init];
        dreserView._hidden=@"yes";
        if ([sign isEqualToString:@"all"])
        {
            dreserView.uid = [[dresserArray objectAtIndex:_index ] objectForKey:@"uid"];
        }
        else if([sign isEqualToString:@"sameCity"])
        {
            dreserView.uid = [[dresserArray1 objectAtIndex:_index ] objectForKey:@"uid"];
        }
        else if([sign isEqualToString:@"introduce"])
        {
            dreserView.uid = [[dresserArray2 objectAtIndex:_index ] objectForKey:@"uid"];
        }
        else if([sign isEqualToString:@"fouce"])
        {
            dreserView.uid = [[dresserArray3 objectAtIndex:_index ] objectForKey:@"uid"];
        }
        NSLog(@"%@", dreserView.uid);
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:dreserView ];
    }
}

-(void)didFouce:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"yes";

        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getDataback2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
        
    }
    else
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=follow"]]];
        request.delegate=self;
        request.tag=2;
       
        
        if ([sign isEqualToString:@"all"])
        {
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
            [request setPostValue:appDele.type forKey:@"type"];
            [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
            if ([[[dresserArray objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
                [request setPostValue:@"0" forKey:@"status"];
            }
            else
            {
                [request setPostValue:@"1" forKey:@"status"];
            }
            
            if ([[[dresserArray objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
            {
                if ([[dresserArray objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray objectAtIndex:_index ]];
                    [dict setObject:@"0" forKey:@"isconcerns"];
                    [dresserArray replaceObjectAtIndex:_index withObject:dict];
                }
            }
            else
            {
                if ([[dresserArray objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray objectAtIndex:_index ]];
                    [dict setObject:@"1" forKey:@"isconcerns"];
                    [dresserArray replaceObjectAtIndex:_index withObject:dict];
                }
            }
            
        }
        else if([sign isEqualToString:@"sameCity"])
        {
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:[[dresserArray1 objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
            [request setPostValue:appDele.type forKey:@"type"];
            [request setPostValue:[[dresserArray1 objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
            if ([[[dresserArray1 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
                [request setPostValue:@"0" forKey:@"status"];
            }
            else
            {
                [request setPostValue:@"1" forKey:@"status"];
            }

            if ([[[dresserArray1 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
            {
                if ([[dresserArray1 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray1 objectAtIndex:_index ]];
                    [dict setObject:@"0" forKey:@"isconcerns"];
                    [dresserArray1 replaceObjectAtIndex:_index withObject:dict];
                }
            }
            else
            {
                if ([[dresserArray1 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray1 objectAtIndex:_index ]];
                    [dict setObject:@"1" forKey:@"isconcerns"];
                    [dresserArray1 replaceObjectAtIndex:_index withObject:dict];
                }
            }

        }
        else if([sign isEqualToString:@"introduce"])
        {
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:[[dresserArray2 objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
            [request setPostValue:appDele.type forKey:@"type"];
            [request setPostValue:[[dresserArray2 objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
            if ([[[dresserArray2 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
                [request setPostValue:@"0" forKey:@"status"];
            }
            else
            {
                [request setPostValue:@"1" forKey:@"status"];
            }

            if ([[[dresserArray2 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
            {
                if ([[dresserArray2 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray2 objectAtIndex:_index ]];
                    [dict setObject:@"0" forKey:@"isconcerns"];
                    [dresserArray2 replaceObjectAtIndex:_index withObject:dict];
                }
            }
            else
            {
                if ([[dresserArray2 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray2 objectAtIndex:_index ]];
                    [dict setObject:@"1" forKey:@"isconcerns"];
                    [dresserArray2 replaceObjectAtIndex:_index withObject:dict];
                }
            }

        }
        else if([sign isEqualToString:@"fouce"])
        {
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:[[dresserArray3 objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
            [request setPostValue:appDele.type forKey:@"type"];
            [request setPostValue:[[dresserArray3 objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
            if ([[[dresserArray3 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
                [request setPostValue:@"0" forKey:@"status"];
            }
            else
            {
                [request setPostValue:@"1" forKey:@"status"];
            }

            if ([[[dresserArray3 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
            {
                if ([[dresserArray3 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray3 objectAtIndex:_index ]];
                    [dict setObject:@"0" forKey:@"isconcerns"];
                    [dresserArray3 replaceObjectAtIndex:_index withObject:dict];
                }
            }
            else
            {
                if ([[dresserArray3 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray3 objectAtIndex:_index ]];
                    [dict setObject:@"1" forKey:@"isconcerns"];
                    [dresserArray3 replaceObjectAtIndex:_index withObject:dict];
                }
            }

        }
        
        [request startAsynchronous];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
