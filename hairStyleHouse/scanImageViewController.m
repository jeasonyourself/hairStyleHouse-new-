//
//  scanImageViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "scanImageViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AllAroundPullView.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

#import "MobClick.h"
@interface scanImageViewController ()

@end

@implementation scanImageViewController
@synthesize worksOrsaveorCan;
//@synthesize selfOrOther;
@synthesize uid;
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
   
    self.view.backgroundColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
    //    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
//    dresserArray =[[NSMutableArray alloc] init];
//    cleandresserArray =[[NSMutableArray alloc] init];

    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    localDresserArray= [[NSMutableArray alloc] init];
    localcleanDresserArray = [[NSMutableArray alloc] init];
    sign=[[NSString alloc] init];
    //数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath;
   
       dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@MyDatabase.db",uid,worksOrsaveorCan]];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) ];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
      [self freashView];//直接本地
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view)
    {
        NSLog(@"loadMore");
        [self pullLoadMore];
            myTableView.frame=CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-15) ;
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    NSLog(@"self.view1:%@",NSStringFromCGRect(self.view.frame));

    NSLog(@"mytable.frame1:%@",NSStringFromCGRect(myTableView.frame));
    
    [self getData];
    
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
    _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
    //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
    _activityIndicatorView.color = [UIColor grayColor];
    //设置活动指示器的颜色
    _activityIndicatorView.hidesWhenStopped = NO;
    //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
    [self.view addSubview:_activityIndicatorView];
    //将对象加入到view
    
    [_activityIndicatorView startAnimating];
}


#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName ;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([worksOrsaveorCan isEqualToString:@"works"])//自己作品
    {
        if ([self.uid isEqualToString:appDele.uid]) {
            cName = [NSString stringWithFormat:@"我的作品"];
        }
        else
        {
            cName = [NSString stringWithFormat:@"他的作品"];

        }
        
    }
    else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
    {
        cName = [NSString stringWithFormat:@"会做作品"];

    }
    
    else//收藏作品
    {
        cName = [NSString stringWithFormat:@"收藏作品"];

    }

    [MobClick beginLogPageView:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName ;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([worksOrsaveorCan isEqualToString:@"works"])//自己作品
    {
        if ([self.uid isEqualToString:appDele.uid]) {
            cName = [NSString stringWithFormat:@"我的作品"];
        }
        else
        {
            cName = [NSString stringWithFormat:@"他的作品"];
            
        }
        
    }
    else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
    {
        cName = [NSString stringWithFormat:@"会做作品"];
        
    }
    
    else//收藏作品
    {
        cName = [NSString stringWithFormat:@"收藏作品"];
        
    }
    [MobClick endLogPageView:cName];
}

-(void)pullLoadMore
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
    
    NSLog(@"self.view2:%@",NSStringFromCGRect(self.view.frame));

    NSLog(@"mytable.frame2:%@",NSStringFromCGRect(myTableView.frame));

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
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
        if ([worksOrsaveorCan isEqualToString:@"works"])//自己作品
        {
            if ([self.uid isEqualToString:appDele.uid]) {
                Lab.text = @"我的作品";
            }
            else
            {
                Lab.text = @"他的作品";
            }
            
        }
        else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
        {
            Lab.text = @"会做作品";
        }
        
            else//收藏作品
            {
                Lab.text = @"收藏作品";
            }
            

        
        
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
    }
    
    
-(void)getData
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        ASIFormDataRequest* request;
//        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        if ([worksOrsaveorCan isEqualToString:@"works"])//原创作品
        {
            
                request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=workslist&page=%@",page]]];
            
            
        }
        else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
        {
            
                request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=willdo&a=willDoList&page=%@",page]]];
            
            
        }
        else//收藏作品
        {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=collectlist&page=%@",page]]];
        }
        
            request.delegate=self;
       
            request.tag=1;
            
            [request setPostValue:self.uid forKey:@"uid"];
        
        
//        [request setPostValue:appDele.secret forKey:@"secret"];
            [request startAsynchronous];

    }
    
-(void)requestFinished:(ASIHTTPRequest *)request
    {
        if (request.tag==1)
        {
            NSMutableArray * arr;
            NSMutableArray * cleanarr;
            
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            
            NSLog(@"Dic111:%@",dic);
            
            pageCount = [dic objectForKey:@"page_count"];
            if ([worksOrsaveorCan isEqualToString:@"works"]||[worksOrsaveorCan isEqualToString:@"save"])//作品或者收藏返回列表
            
            {
                
            
            if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
            {
                
            }
            else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
            {
                arr= [dic objectForKey:@"works_info"];
                [localDresserArray addObjectsFromArray:arr];
            }
            
            }
        
            else//会做列表返回
            {
                    if ([[dic objectForKey:@"willdo_info"] isKindOfClass:[NSString class]])//返回为空
                    {
                        
                    }
                    else if ([[dic objectForKey:@"willdo_info"] isKindOfClass:[NSArray class]])//有返回
                    {
                        arr= [dic objectForKey:@"willdo_info"];
                        [localDresserArray addObjectsFromArray:arr];
                    }
            }
            
            if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
            {
                
            }
            else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
            {
                cleanarr= [dic objectForKey:@"image_list"];
                [localcleanDresserArray addObjectsFromArray:cleanarr];
                
            }
            
            [self freashView];

        }
        
        
        
        else if (request.tag==202)
        {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            
            NSLog(@"Dic111:%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
                
                NSLog(@"删除成功");
            }
            else
            {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"啊哦，删除出错了！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
        }
        
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;

        
        
        
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;

     [self freashView];
}

    -(void)freashView
    {
        NSLog(@"local:%d  %@",localDresserArray.count,localDresserArray);
        NSLog(@"localClean:%d  %@",localcleanDresserArray.count,localcleanDresserArray);
        
        
        [bottomRefreshView performSelector:@selector(finishedLoading)];
       
        [myTableView reloadData];

    }



    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        
        if (localDresserArray.count%2==0)
        {
            return localDresserArray.count/2;
        }
        else
        {
            return localDresserArray.count/2+1;
        }
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return   230;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellID=@"cell";
        scanCell *cell=(scanCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[scanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.fatherView =self;
        }
        cell.backgroundColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
        NSUInteger row1 = [indexPath row]*2;
        NSLog(@"row1:%d",row1);
        NSUInteger row2 = [indexPath row]*2+1;
        NSLog(@"row2:%d",row2);
//        NSUInteger row3 = [indexPath row]*2+2;
//        NSLog(@"row3:%d",row3);
//        cell.backgroundColor = [UIColor blueColor];
        if (row1<localDresserArray.count)//防止可能越界
        {
            [cell setCell:[localDresserArray objectAtIndex:row1] andIndex:row1];
        }
        if (row2<localDresserArray.count)//防止可能越界
        {
            [cell setCell:[localDresserArray objectAtIndex:row2] andIndex:row2];
        }
//        if (row3<localDresserArray.count)//防止可能越界
//        {
//            [cell setCell:[localDresserArray objectAtIndex:row3] andIndex:row3];
//        }

    return cell;
    }



-(void)selectImage:(NSInteger)_index
{
    int count = localcleanDresserArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [[localcleanDresserArray[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.work_id =[localcleanDresserArray[i] objectForKey:@"work_id"];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    browser=nil;
    browser = [[MJPhotoBrowser alloc] init];
    NSInteger reallIndex;
    NSString * str = [localDresserArray[_index] objectForKey:@"work_id"];
    for (int i = 0; i<count; i++)//获得真实位置
    {
        // 替换为中等尺寸图片
        NSString *string1 = [localcleanDresserArray[i] objectForKey:@"work_id"];
        if ([string1 isEqualToString:str])
        {
            reallIndex =i;
            break;
        }
    }
    
    browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？ // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [self.navigationController pushViewController:browser animated:YES];
    //    [browser show];
}

-(void)deleteImage:(NSInteger)_index
{


    if (_index==localDresserArray.count-1)//最后一个
    {
        int count = localcleanDresserArray.count;
        NSString * str1 = [localDresserArray[_index] objectForKey:@"work_id"];
        for (int i = 0; i<count; i++)//获得真实位置
        {
            
            NSString *string1 = [localcleanDresserArray[i] objectForKey:@"work_id"];
            if ([string1 isEqualToString:str1])
            {
                for (int j = i; j<localcleanDresserArray.count; j++) {
                    [localcleanDresserArray removeObjectAtIndex:j];
                }
                break;
            }
        }
    }
    
    else
    {
        
        
    NSInteger index1=0;
    NSInteger index2=0;
    NSString * str1 = [localDresserArray[_index] objectForKey:@"work_id"];
    NSString * str2 = [localDresserArray[_index+1] objectForKey:@"work_id"];
        NSLog(@"_index:%d",_index);
        NSLog(@"_index+1:%d",_index+1);
        NSLog(@"str1:%@",str1);
         NSLog(@"str2:%@",str2);
        
        for (int i = 0; i<localcleanDresserArray.count; i++)//获得真实位置
    {
        NSString *string1 = [localcleanDresserArray[i] objectForKey:@"work_id"];
        if ([string1 isEqualToString:str1])
        {
            index1 =i;
            break;
        }
    }
        
        for (int i = 0; i<localcleanDresserArray.count; i++)//获得真实位置
        {
            // 替换为中等尺寸图片
            NSString *string1 = [localcleanDresserArray[i] objectForKey:@"work_id"];
            if ([string1 isEqualToString:str2])
            {
                index2 =i;
                break;
            }
        }
        
    [localcleanDresserArray removeObjectsInRange:NSMakeRange(index1, index2-index1)];
    
    }

    NSDictionary * _dic =[localDresserArray objectAtIndex:_index];
    [localDresserArray removeObjectAtIndex:_index];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

      ASIFormDataRequest* request;
    if ([worksOrsaveorCan isEqualToString:@"works"])//原创作品
    {
        
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=works&a=worksDel"]]];
        
        
    }
    else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
    {
        
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=willdo&a=willDoDel"]]];
        
        
    }
    else//收藏作品
    {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=works&a=collectDel"]]];
    }
    
    request.delegate=self;
    
    request.tag=202;
    
    [request setPostValue:self.uid forKey:@"uid"];
    [request setPostValue:appDele.secret forKey:@"secret"];
    [request setPostValue:[_dic objectForKey:@"work_id"] forKey:@"work_id"];
    [request startAsynchronous];
    
    
    

    [self freashView];
//    [_activityIndicatorView startAnimating];

}

-(void)shareImage:(NSInteger)_index
{
    NSLog(@"分享开始");
    shareIndex = _index;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
//        [fatherView pushViewController:nil];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择方式"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"分享到QQ空间"
                                      otherButtonTitles:@"分享到新浪微博",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        TencentOAuth* _tentenOAuth;
        AppDelegate* dele=(AppDelegate*)[UIApplication sharedApplication].delegate;
        
        _tentenOAuth=dele.tententOAuth;
        //
        //            NSLog(@"_tentenOAuth:%@",_tentenOAuth.accessToken);
        //             NSLog(@"_tentenOAuth:%@",_tentenOAuth.openId);
        //            NSLog(@"_tentenOAuth:%@",_tentenOAuth.expirationDate);
        
        TCAddShareDic *params = [TCAddShareDic dictionary];
        params.paramTitle = @"我通过使用发型屋找到一款很好看的发型，点击跳转";
        params.paramComment = @"潮流必备软件——发型屋";
        params.paramSummary= @"发型屋是一款潮流达人必备的一款软件，它可以帮助你找到你想要的发型，在线预约发型师，折扣价格，查看他人推荐发型并实时聊天";
        
//        NSLog(@"%@",[diction objectForKey:@"works_pic"]);
        
        params.paramImages = [[localDresserArray objectAtIndex:shareIndex] objectForKey:@"work_image"] ;
        params.paramUrl = [NSString stringWithFormat:@"http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[[localDresserArray objectAtIndex:shareIndex] objectForKey:@"work_id"] ];
        
        if(![_tentenOAuth addShareWithParams:params])
        {
            sign =@"qq";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"你尚未绑定QQ账号,或你的账号授权已过期,需要重新获取" delegate:self cancelButtonTitle:@"暂不绑定" otherButtonTitles:@"现在绑定", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"操作成功"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
    
    if (buttonIndex == 1)
    {
        AppDelegate* dele=(AppDelegate*)[UIApplication sharedApplication].delegate;
        SinaWeibo* _sinaWeibo=dele.sinaweibo;
//        NSLog(@"%@",[diction objectForKey:@"works_pic"]);
        NSString* upText=[@"" stringByAppendingFormat:@"我通过使用发型屋找到一款很好看的发型，点击跳转>>>>>http://www.faxingw.cn/soufaxing/%@_hairpic.html",[[localDresserArray objectAtIndex:shareIndex] objectForKey:@"work_id"]];
        [_sinaWeibo requestWithURL:@"statuses/upload.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    upText, @"status",
                                    [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[localDresserArray objectAtIndex:shareIndex] objectForKey:@"work_image"]]]], @"pic", nil]
                        httpMethod:@"POST"
                          delegate:self];
        //            NSString* upText=[NSString stringWithFormat:@"我通过使用发型屋找到一款很好看的发型，点击跳转>>>>>http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[diction objectForKey:@"works_id"]];
        //            [_sinaWeibo requestWithURL:@"statuses/upload.json"
        //                                params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
        //                                        upText, @"status",
        //                                        [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[diction objectForKey:@"works_id"]]]]], @"pic", nil]
        //                            httpMethod:@"POST"
        //                              delegate:self];
    }
    else if(buttonIndex == 2)
    {
        
    }
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"move failed:%@", [error localizedDescription]);
    sign =@"sina";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"你尚未绑定新浪微博账号,或你的账号授权已过期,需要重新获取" delegate:self cancelButtonTitle:@"暂不绑定" otherButtonTitles:@"现在绑定", nil];
    [alert show];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //    [self.indicator stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"操作成功"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1)
    {
        rigView = nil;
        rigView  = [[rigViewController alloc] init] ;
        rigView._hidden = NO;
        rigView._backsign = sign;
//        [rigView getBack:self andSuc:@selector(rigThenshare) andErr:nil];
        [self.navigationController  pushViewController:rigView animated:NO];
        
    }
    else
    {
        
    }
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
