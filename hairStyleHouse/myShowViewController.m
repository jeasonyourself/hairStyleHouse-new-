//
//  myShowViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-9.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "myShowViewController.h"
#import "findStyleDetailViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AllAroundPullView.h"
@interface myShowViewController ()

@end

@implementation myShowViewController
@synthesize style;
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
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setBackgroundColor:[UIColor whiteColor]];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitle:@"最新榜" forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitle:@"评论榜" forState:UIControlStateNormal];

    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton setTitle:@"排行榜" forState:UIControlStateNormal];
     [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    cleandresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    dresserArray1 =[[NSMutableArray alloc] init];
    cleandresserArray1 =[[NSMutableArray alloc] init];
    page1 =[[NSString alloc] init];
    page1=@"1";
    pageCount1=[[NSString alloc] init];
    dresserArray2 =[[NSMutableArray alloc] init];
    cleandresserArray2 =[[NSMutableArray alloc] init];

    page2 =[[NSString alloc] init];
    page2=@"1";
    pageCount2=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"add_time";
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-50) style:UITableViewStylePlain];
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
    
    
    [self getData];
    [self getData1];
    [self getData2];
}
-(void)pullLoadMore
{
    if ([sign isEqualToString:@"add_time"])
    {
        NSInteger _pageCount= [pageCount integerValue];
        
        NSInteger _page = [page integerValue];
        
        NSLog(@"page:%@",page);
        NSLog(@"pageCount:%@",pageCount);
        
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
    else
        if ([sign isEqualToString:@"comment_num"])
        {
            NSInteger _pageCount= [pageCount1 integerValue];
            
            NSInteger _page = [page1 integerValue];
            
            NSLog(@"page:%@",page1);
            NSLog(@"pageCount:%@",pageCount1);
            
            if (_page<_pageCount) {
                _page++;
                page = [NSString stringWithFormat:@"%d",_page];
                NSLog(@"page:%@",page1);
                [self getData1];
            }
            else
            {
                [bottomRefreshView performSelector:@selector(finishedLoading)];
                
            }

        }
        else
            if ([sign isEqualToString:@"collect_num"])
            {
                NSInteger _pageCount= [pageCount2 integerValue];
                
                NSInteger _page = [page2 integerValue];
                
                NSLog(@"page:%@",page2);
                NSLog(@"pageCount:%@",pageCount2);
                
                if (_page<_pageCount) {
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
    }


-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign = @"add_time";
    [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"comment_num";
    
    [myTableView reloadData];
}
-(void)thirdButtonClick
{
    [thirdButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign = @"collect_num";
    [myTableView reloadData];
    
}
-(void)getData
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Dynamic&a=ranking&page=%@",page]]];
    
    
    [request setPostValue:@"add_time" forKey:@"condition"];
    
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
}

-(void)getData1
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Dynamic&a=ranking&page=%@",page]]];
    
    
    [request setPostValue:@"comment_num" forKey:@"condition"];
    
    request.delegate=self;
    request.tag=2;
    [request startAsynchronous];
}
-(void)getData2
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Dynamic&a=ranking&page=%@",page]]];
    
    
    [request setPostValue:@"collect_num" forKey:@"condition"];
    
    request.delegate=self;
    request.tag=3;
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray * arr;
    NSMutableArray * arr1;

    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类%@发型dic:%@",style,sign,dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"works_info"];
            [dresserArray addObjectsFromArray:arr];

            NSLog(@"dresser.count:%d",dresserArray.count);
            
        }
        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
        {
            arr1= [dic objectForKey:@"image_list"];
            
            [cleandresserArray addObjectsFromArray:arr1];
            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);

            
        }
        [self freashView];
    }
    else if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类%@发型dic:%@",style,sign,dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"works_info"];
            [dresserArray1 addObjectsFromArray:arr];

            NSLog(@"dresser1.count:%d",dresserArray1.count);
            
        }
        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
        {
            arr1= [dic objectForKey:@"image_list"];
            
            [cleandresserArray1 addObjectsFromArray:arr1];
            NSLog(@"cleandresserArray1.count:%d",cleandresserArray1.count);

            
        }
        [self freashView];
    }
    else if (request.tag==3) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类%@发型dic:%@",style,sign,dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"works_info"];
            [dresserArray2 addObjectsFromArray:arr];

            NSLog(@"dresser2.count:%d",dresserArray2.count);
            
        }
        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
        {
            arr1= [dic objectForKey:@"image_list"];
            
            [cleandresserArray2 addObjectsFromArray:arr1];
            
            NSLog(@"cleandresserArray2.count:%d",cleandresserArray2.count);

        }
        [self freashView];
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
    if ([sign isEqualToString:@"add_time"])
    {
        if (dresserArray.count%2==0)
        {
            return dresserArray.count/2;
        }
        else
        {
            return dresserArray.count/2+1;
        }
    }
    else
        if ([sign isEqualToString:@"comment_num"])
        {
            if (dresserArray1.count%2==0)
            {
                return dresserArray1.count/2;
            }
            else
            {
                return dresserArray1.count/2+1;
            }
        }
        else
            if ([sign isEqualToString:@"collect_num"])
            {
                if (dresserArray2.count%2==0)
                {
                    return dresserArray2.count/2;
                }
                else
                {
                    return dresserArray2.count/2+1;
                }
            }
   else
   {
       if (dresserArray.count%2==0)
       {
           return dresserArray.count/2;
       }
       else
       {
           return dresserArray.count/2+1;
       }
   }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   180;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    myShowCell *cell=(myShowCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[myShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row1 = [indexPath row]*2;
    NSLog(@"row1:%d",row1);
    NSUInteger row2 = [indexPath row]*2+1;
    NSLog(@"row2:%d",row2);
//    NSUInteger row3 = [indexPath row]*3+2;
//    NSLog(@"row3:%d",row3);
    
    if ([sign isEqualToString:@"add_time"])
    {
        [cell setCell:[dresserArray objectAtIndex:row1] andIndex:row1];
        
        if (row2<dresserArray.count)//防止可能越界
        {
            [cell setCell:[dresserArray objectAtIndex:row2] andIndex:row2];
        }
    }
    else
        if ([sign isEqualToString:@"comment_num"])
        {
            [cell setCell:[dresserArray1 objectAtIndex:row1] andIndex:row1];
            
            if (row2<dresserArray1.count)//防止可能越界
            {
                [cell setCell:[dresserArray1 objectAtIndex:row2] andIndex:row2];
            }
        }
        else
            if ([sign isEqualToString:@"collect_num"])
            {
                [cell setCell:[dresserArray2 objectAtIndex:row1] andIndex:row1];
                
                if (row2<dresserArray2.count)//防止可能越界
                {
                    [cell setCell:[dresserArray2 objectAtIndex:row2] andIndex:row2];
                }
                }

    
    return cell;
    
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
-(void)rightButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"no";
        loginView.view.frame=self.view.bounds;
        //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
    }
    else
    {

    pubImage = nil;
    pubImage = [[pubImageViewController alloc] init];
    pubImage._hidden =@"no";
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [appDele pushToViewController:pubImage];
        
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
    
    UIButton * rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton.layer setMasksToBounds:YES];
    [rightButton.layer setCornerRadius:3.0];
    [rightButton.layer setBorderWidth:1.0];
    [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [rightButton setTitle:@"上传图片" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rightButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    
    
        Lab.text = @"我型我秀";

    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectImage:(NSInteger)_index
{
    if ([sign isEqualToString:@"add_time"])
    {
        int count = cleandresserArray.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i<count; i++)
        {
            // 替换为中等尺寸图片
            NSString *string1 = [cleandresserArray[i] objectForKey:@"work_image"];
            NSString *string2 = [string1 substringWithRange:NSMakeRange(1, string1.length-1)];
            
            NSString *url = [string2 stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.work_id =[cleandresserArray[i] objectForKey:@"work_id"];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
            [photos addObject:photo];
            
        }
        browser=nil;
        browser = [[MJPhotoBrowser alloc] init];
        NSInteger reallIndex;
        NSString * str = [dresserArray[_index] objectForKey:@"work_id"];
        for (int i = 0; i<count; i++)//获得真实位置
        {
            // 替换为中等尺寸图片
            NSString *string1 = [cleandresserArray[i] objectForKey:@"work_id"];
            if ([string1 isEqualToString:str])
            {
                reallIndex =i;
                break;
            }
        }

        browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？
        browser.photos = photos;

    }
    else if ([sign isEqualToString:@"comment_num"])
        {
            int count = cleandresserArray1.count;
            // 1.封装图片数据
            NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i<count; i++)
            {
                // 替换为中等尺寸图片
                NSString *string1 = [cleandresserArray1[i] objectForKey:@"work_image"];
                NSString *string2 = [string1 substringWithRange:NSMakeRange(1, string1.length-1)];//去掉第一个空格
                
                NSString *url = [string2 stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
                MJPhoto *photo = [[MJPhoto alloc] init];
                photo.work_id =[cleandresserArray1[i] objectForKey:@"work_id"];
                photo.url = [NSURL URLWithString:url]; // 图片路径
                //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
                [photos addObject:photo];
               
            }
            browser=nil;
            browser = [[MJPhotoBrowser alloc] init];
            NSInteger reallIndex;
            NSString * str = [dresserArray1[_index] objectForKey:@"work_id"];
            for (int i = 0; i<count; i++)//获得真实位置
            {
                // 替换为中等尺寸图片
                NSString *string1 = [cleandresserArray1[i] objectForKey:@"work_id"];
                if ([string1 isEqualToString:str])
                {
                    reallIndex =i;
                    break;
                }
            }

            browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？
            browser.photos = photos;
        }
        else
            if ([sign isEqualToString:@"collect_num"])
            {
                int count = cleandresserArray2.count;
                // 1.封装图片数据
                NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
                for (int i = 0; i<count; i++) {
                    // 替换为中等尺寸图片
                    NSString *string1 = [cleandresserArray2[i] objectForKey:@"work_image"];
                    NSString *string2 = [string1 substringWithRange:NSMakeRange(1, string1.length-1)];
                    
                    NSString *url = [string2 stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
                    MJPhoto *photo = [[MJPhoto alloc] init];
                    photo.work_id =[cleandresserArray2[i] objectForKey:@"work_id"];
                    photo.url = [NSURL URLWithString:url]; // 图片路径
                    //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
                    [photos addObject:photo];
                   
            }
                browser=nil;
                browser = [[MJPhotoBrowser alloc] init];
                NSInteger reallIndex;
                NSString * str = [dresserArray2[_index] objectForKey:@"work_id"];
                for (int i = 0; i<count; i++)
                {
                    // 替换为中等尺寸图片
                    NSString *string1 = [cleandresserArray2[i] objectForKey:@"work_id"];
                    if ([string1 isEqualToString:str])
                    {
                        reallIndex =i;
                        break;
                    }
                }
                browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？
                browser.photos = photos;
    
            }
    // 2.显示相册
    // 设置所有的图片
    [self.navigationController pushViewController:browser animated:YES];
    //    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
