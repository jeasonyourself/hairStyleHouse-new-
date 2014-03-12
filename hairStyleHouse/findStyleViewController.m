//
//  findStyleViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "findStyleViewController.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "BaiduMobStat.h"

@interface findStyleViewController ()

@end

@implementation findStyleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = @"找发型";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;

//        subView.frame=CGRectMake(0, 0, 320, 160); //设置frame
//        [self.view addSubview:subView];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    showLocalSuccess=YES;
    
    self.view.backgroundColor = [UIColor redColor];

    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"您关闭了的定位功能，将无法收到位置信息，建议您到系统设置打开定位功能!");
    }
    else
    {
    locationManager = [[CLLocationManager alloc] init];//创建位置管理器
    locationManager.delegate=self;//设置代理
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    locationManager.distanceFilter=100.0f;//设置距离筛选器
    [locationManager startUpdatingLocation];//启动位置管理器
    }
    
     backView = [[[NSBundle mainBundle] loadNibNamed:@"oprationMenue" owner:self options:nil] objectAtIndex:0];
    [self.view addSubview:backView];
    
    
    whichDic = [[NSString alloc] initWithFormat:@"1"];
    firstArr = [[NSArray alloc] initWithArray:[hairStyleCategory shareData].firstArray];
    NSLog(@"firstArr:%@",firstArr);
    
    secondArr = [[NSArray alloc] initWithArray:[hairStyleCategory shareData].secondArray];
    thirdArr = [[NSArray alloc] initWithArray:[hairStyleCategory shareData].thirdArray];
    forthArr = [[NSArray alloc] initWithArray:[hairStyleCategory shareData].forthArray];
    fifthArr = [[NSArray alloc] initWithArray:[hairStyleCategory shareData].fifthArray];
    sixthArr = [[NSArray alloc] initWithArray:[hairStyleCategory shareData].sixthArray];
    
    
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(81, self.navigationController.navigationBar.frame.size.height+20, self.view.bounds.size.width-80, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-20-self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.allowsSelection=NO;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    [self.view addSubview:myTableView];
    
    if(iPhone5)
    {
        
    }
    else{
        _signImage.hidden=YES;

        _firstImage.hidden=YES;
        _secondImage.hidden=YES;
        _thirdImage.hidden=YES;
        _forthImage.hidden=YES;
        _fifthImage.hidden=YES;
        _sixthImage.hidden=YES;
        
        _firstLable.hidden=YES;
        _secondLable.hidden=YES;
        _thirdLable.hidden=YES;
        _forthLable.hidden=YES;
        _fifthLable.hidden=YES;
        _sixthLable.hidden=YES;
       

    }
//    [self cView];
	// Do any additional setup after loading the view.
}
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"找发型"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];

    if(iPhone5)
    {
        
    }
    else
    {
        _signImage.hidden=NO;
        _firstImage.hidden=NO;
        _secondImage.hidden=NO;
        _thirdImage.hidden=NO;
        _forthImage.hidden=NO;
        _fifthImage.hidden=NO;
        _sixthImage.hidden=NO;
        
        _firstLable.hidden=NO;
        _secondLable.hidden=NO;
        _thirdLable.hidden=NO;
        _forthLable.hidden=NO;
        _fifthLable.hidden=NO;
        _sixthLable.hidden=NO;
        
        _signImage.frame = CGRectMake(signOrigionY,signOrigionX-20 , 15, 15);

        _firstImage.frame = CGRectMake(8, 82, 20, 20);
        _secondImage.frame = CGRectMake(8, 144, 20, 20);
        _thirdImage.frame = CGRectMake(8, 205, 20, 20);
        _forthImage.frame = CGRectMake(8, 265, 20, 20);
        _fifthImage.frame = CGRectMake(8, 325, 20, 20);
        _sixthImage.frame = CGRectMake(8, 385, 20, 20);


        _firstLable.frame = CGRectMake(32, 83, 35, 21);
        _secondLable.frame = CGRectMake(32, 145, 35, 21);
        _thirdLable.frame = CGRectMake(32, 205, 35, 21);
        _forthLable.frame = CGRectMake(32, 265, 35, 21);
        _fifthLable.frame = CGRectMake(32, 325, 35, 21);
        _sixthLable.frame = CGRectMake(32, 385, 35, 21);
        
        
        
        _firstButton.frame= CGRectMake(-2, 75, 75, 60);
        _secondButton.frame= CGRectMake(-2, 135, 75, 60);
        _thirdButton.frame= CGRectMake(-2, 195, 75, 60);
        _forthButton.frame= CGRectMake(-2, 255, 75, 60);
        _fifthButton.frame= CGRectMake(-2, 315, 75, 60);
        _sixthButton.frame= CGRectMake(-2, 375, 75, 60);
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"找发型"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([whichDic isEqualToString:@"1"])
    {
        if (firstArr.count%3==0)
        {
            return firstArr.count/3;
        }
        else
        {
            return firstArr.count/3+1;
        }
      
    }
    else if ([whichDic isEqualToString:@"2"])
    {
        if (secondArr.count%3==0)
        {
            return secondArr.count/3;
        }
        else
        {
            return secondArr.count/3+1;
        }
    }
    else if ([whichDic isEqualToString:@"3"])
    {
        if (thirdArr.count%3==0)
        {
            return thirdArr.count/3;
        }
        else
        {
            return thirdArr.count/3+1;
        }
    }
    else if ([whichDic isEqualToString:@"4"])
    {
        if (forthArr.count%3==0)
        {
            return forthArr.count/3;
        }
        else
        {
            return forthArr.count/3+1;
        }
    }
    else if ([whichDic isEqualToString:@"5"])
    {
        if (fifthArr.count%3==0)
        {
            return fifthArr.count/3;
        }
        else
        {
            return fifthArr.count/3+1;
        }
    }
    else if ([whichDic isEqualToString:@"6"])
    {
        if (sixthArr.count%3==0)
        {
            return sixthArr.count/3;
        }
        else
        {
            return sixthArr.count/3+1;
        }
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
//    if ([appDele.type isEqualToString:@"1"])
//    {
//        return   self.view.frame.size.height;
//        
//    }
//    else if ([appDele.type isEqualToString:@"2"])
//    {
//        return   self.view.frame.size.height+120;
//        
//    }
//    else
//        
//    {
    return   110;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    hairStyleIconCell *cell=(hairStyleIconCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[hairStyleIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row1 = [indexPath row]*3;
    NSLog(@"row1:%d",row1);
    NSUInteger row2 = [indexPath row]*3+1;
    NSLog(@"row2:%d",row2);
    NSUInteger row3 = [indexPath row]*3+2;
    NSLog(@"row3:%d",row3);
    
    if ([whichDic isEqualToString:@"1"])
    {
        if (row1<firstArr.count)//防止可能越界
        {

        [cell setCell:[firstArr objectAtIndex:row1] andIndex:row1];
        }
        if (row2<firstArr.count)//防止可能越界
        {
            [cell setCell:[firstArr objectAtIndex:row2] andIndex:row2];
        }
        if (row3<firstArr.count)//防止可能越界
        {
            [cell setCell:[firstArr objectAtIndex:row3] andIndex:row3];
        }

    }
    else if ([whichDic isEqualToString:@"2"])
    {
        if (row1<secondArr.count)//防止可能越界
        {
            
            [cell setCell:[secondArr objectAtIndex:row1] andIndex:row1];
        }
        if (row2<secondArr.count)//防止可能越界
        {
            [cell setCell:[secondArr objectAtIndex:row2] andIndex:row2];
        }
        if (row3<secondArr.count)//防止可能越界
        {
            [cell setCell:[secondArr objectAtIndex:row3] andIndex:row3];
        }
    }
    else if ([whichDic isEqualToString:@"3"])
    {
        if (row1<thirdArr.count)//防止可能越界
        {
            
            [cell setCell:[thirdArr objectAtIndex:row1] andIndex:row1];
        }
        if (row2<thirdArr.count)//防止可能越界
        {
            [cell setCell:[thirdArr objectAtIndex:row2] andIndex:row2];
        }
        if (row3<thirdArr.count)//防止可能越界
        {
            [cell setCell:[thirdArr objectAtIndex:row3] andIndex:row3];
        }
    }
    else if ([whichDic isEqualToString:@"4"])
    {
        [cell setCell:[forthArr objectAtIndex:row1] andIndex:row1];
        
        if (row2<forthArr.count)//防止可能越界
        {
            [cell setCell:[forthArr objectAtIndex:row2] andIndex:row2];
        }
        if (row3<forthArr.count)//防止可能越界
        {
            [cell setCell:[forthArr objectAtIndex:row3] andIndex:row3];
        }
    }
    else if ([whichDic isEqualToString:@"5"])
    {
        [cell setCell:[fifthArr objectAtIndex:row1] andIndex:row1];
        
        if (row2<fifthArr.count)//防止可能越界
        {
            [cell setCell:[fifthArr objectAtIndex:row2] andIndex:row2];
        }
        if (row3<fifthArr.count)//防止可能越界
        {
            [cell setCell:[fifthArr objectAtIndex:row3] andIndex:row3];
        }
    }
    else if ([whichDic isEqualToString:@"6"])
    {
        [cell setCell:[sixthArr objectAtIndex:row1] andIndex:row1];
        
        if (row2<sixthArr.count)//防止可能越界
        {
            [cell setCell:[sixthArr objectAtIndex:row2] andIndex:row2];
        }
        if (row3<sixthArr.count)//防止可能越界
        {
            [cell setCell:[sixthArr objectAtIndex:row3] andIndex:row3];
        }
    }
    cell.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    return cell;
}

-(void)selectImage:(NSInteger)_index
{
   
    if ([whichDic isEqualToString:@"1"])
    {
        switch (_index) {
            case 0:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"1";
                findStyleDetail.scid=@"9";
                findStyleDetail.style=[secondArr[8]  objectForKey:@"nameArr"];
                
                break;
            case 1:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"1";
                findStyleDetail.scid=@"7";
                findStyleDetail.style=[secondArr[6]  objectForKey:@"nameArr"];

                break;
            case 2:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"4";
                findStyleDetail.scid=@"4";
                findStyleDetail.style=[fifthArr[3]  objectForKey:@"nameArr"];

                break;
            case 3:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"4";
                findStyleDetail.scid=@"1";
                findStyleDetail.style=[fifthArr[0]  objectForKey:@"nameArr"];

                break;
            case 4:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"1";
                findStyleDetail.scid=@"4";
                findStyleDetail.style=[secondArr[3]  objectForKey:@"nameArr"];

                break;
            case 5:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"1";
                findStyleDetail.scid=@"5";
                findStyleDetail.style=[secondArr[4]  objectForKey:@"nameArr"];

                break;
            case 6:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"2";
                findStyleDetail.scid=@"9";
                findStyleDetail.style=@"男明星";

                break;
            case 7:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"1";
                findStyleDetail.scid=@"10";
                findStyleDetail.style=@"女明星";

                break;
            case 8:
                findStyleDetail = nil;
                findStyleDetail = [[findStyleDetailViewController alloc] init];
                findStyleDetail.bcid=@"5";
                findStyleDetail.scid=@"2";
                findStyleDetail.style=[sixthArr[1]  objectForKey:@"nameArr"];

                break;
            default:
                break;
        }
    }
    else if ([whichDic isEqualToString:@"2"])
    {
        findStyleDetail = nil;
        findStyleDetail = [[findStyleDetailViewController alloc] init];
        findStyleDetail.bcid=@"1";
        findStyleDetail.scid=[NSString stringWithFormat:@"%d",_index+1];
        findStyleDetail.style=[secondArr[_index]  objectForKey:@"nameArr"];

    }
    else if ([whichDic isEqualToString:@"3"])
    {
        findStyleDetail = nil;
        findStyleDetail = [[findStyleDetailViewController alloc] init];
        findStyleDetail.bcid=@"2";
        findStyleDetail.scid=[NSString stringWithFormat:@"%d",_index+1];
        findStyleDetail.style=[thirdArr[_index]  objectForKey:@"nameArr"];

    }
    else if ([whichDic isEqualToString:@"4"])
    {
        findStyleDetail = nil;
        findStyleDetail = [[findStyleDetailViewController alloc] init];
        findStyleDetail.bcid=@"3";
        findStyleDetail.scid=[NSString stringWithFormat:@"%d",_index+1];
        findStyleDetail.style=[forthArr[_index]  objectForKey:@"nameArr"];

    }
    else if ([whichDic isEqualToString:@"5"])
    {
        findStyleDetail = nil;
        findStyleDetail = [[findStyleDetailViewController alloc] init];
        findStyleDetail.bcid=@"4";
        findStyleDetail.scid=[NSString stringWithFormat:@"%d",_index+1];
        findStyleDetail.style=[fifthArr[_index]  objectForKey:@"nameArr"];

    }
    else if ([whichDic isEqualToString:@"6"])
    {
        findStyleDetail = nil;
        findStyleDetail = [[findStyleDetailViewController alloc] init];
        findStyleDetail.bcid=@"5";
        findStyleDetail.scid=[NSString stringWithFormat:@"%d",_index+1];
        findStyleDetail.style=[sixthArr[_index]  objectForKey:@"nameArr"];

    }
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    [ appDele pushToViewController:findStyleDetail];
}


-(void)cView
{
    for (int i=0; i<3; i++) {
        for (int j=0; j<2; j++) {
            UIImageView* imageView=[[UIImageView alloc] init];
            imageView.frame=CGRectMake(20+150*j, 10+145*i+(self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-self.navigationController.navigationBar.frame.size.height-140)/4, 130, 121);
            imageView.tag=i*2+j;
            imageView.userInteractionEnabled=YES;
//            [self.view addSubview:imageView];
        }
    }
    UITapGestureRecognizer* tap;
    
    for (UIImageView* imageView in self.view.subviews) {
        switch (imageView.tag) {
            case 0:
                [imageView setImage:[UIImage imageNamed:@"短发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//                [imageView addGestureRecognizer:tap];
                break;
            case 1:
                [imageView setImage:[UIImage imageNamed:@"中发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//                [imageView addGestureRecognizer:tap];
                break;
            case 2:
                [imageView setImage:[UIImage imageNamed:@"长发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//                [imageView addGestureRecognizer:tap];
                break;
            case 3:
                [imageView setImage:[UIImage imageNamed:@"盘发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//                [imageView addGestureRecognizer:tap];
                break;
            case 4:
                [imageView setImage:[UIImage imageNamed:@"男士发型.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//                [imageView addGestureRecognizer:tap];
                break;
            case 5:
                [imageView setImage:[UIImage imageNamed:@"其他.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
//                [imageView addGestureRecognizer:tap];
                break;
            default:
                break;
        }
    }
}

-(void)tapView:(UITapGestureRecognizer* )tap
{
    findStyleDetail =nil;
    findStyleDetail = [[findStyleDetailViewController alloc] init];
    switch (tap.view.tag) {
        case 0:
            findStyleDetail.style=@"1";
            break;
        case 1:
            findStyleDetail.style=@"2";
            break;
        case 2:
            findStyleDetail.style=@"3";
            break;
        case 3:
            findStyleDetail.style=@"4";
            break;
        case 4:
            findStyleDetail.style=@"5";
            break;
        case 5:
            findStyleDetail.style=@"6";
            break;
            
        default:
            break;
    }
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//
//    [ appDele pushToViewController:findStyleDetail];
    
}

#pragma mark CLLocationManager delegate
//定位成功调用
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"定位成功！");
    CLLocationCoordinate2D loc = [newLocation coordinate];
    
    NSLog(@"%f",loc.latitude);
    NSLog(@"%f",loc.longitude);
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    appDele.latitude=loc.latitude;
    appDele.longitude=loc.longitude;
    
    [locationManager stopUpdatingLocation];

    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder  reverseGeocodeLocation: newLocation completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         for (CLPlacemark *placemark in placemarks) {
             
             NSString * citystring =[NSString stringWithFormat: @"你当前的位置是：%@%@%@",placemark.administrativeArea,placemark.locality,placemark.subLocality];
//             AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
             appDele.city=placemark.locality;
             NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];
             [ud setObject:[NSString stringWithFormat:@"%f",appDele.latitude] forKey:@"lat"];
             [ud setObject:[NSString stringWithFormat:@"%f",appDele.longitude] forKey:@"long"];
             [ud setObject:appDele.city forKey:@"city"];
                if (showLocalSuccess==YES)
                {
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:citystring delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
             [alert show];
                    showLocalSuccess=NO;
                }
             
             NSLog(@"name:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@\n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",placemark.name,placemark.country,placemark.postalCode,placemark.ISOcountryCode,placemark.ocean,placemark.inlandWater,placemark.administrativeArea,placemark.subAdministrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.subThoroughfare);
             
             [geocoder cancelGeocode];
            
//             [self getData];
             
         }
     }];

}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=coordinates"]]];
    request.delegate=self;
    request.tag=1;
    
   
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ] forKey:@"lng"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
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
    NSLog(@"修改经纬度dic:%@",dic);
}
//定位出错时被调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSUserDefaults* ud=[NSUserDefaults standardUserDefaults];

    if ([ud objectForKey:@"uid"]&&[ud objectForKey:@"type"])
            {
                appDele.city =[ud objectForKey:@"city"];
                appDele.latitude = [[ud objectForKey:@"lat"] doubleValue];
                appDele.longitude = [[ud objectForKey:@"long"] doubleValue];
            }
    if (showLocalSuccess==YES) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        showLocalSuccess=NO;
    }
   
    NSLog(@"获取经纬度失败，失败原因：%@", [error description]);
}

- (void) startLocation

{
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"您关闭了的定位功能，将无法收到位置信息，建议您到系统设置打开定位功能!");
    }
    else
    {
        CLLocationManager *myLocationManager = [[CLLocationManager alloc]init];
        myLocationManager.delegate = self;
        //        NSLog(@"PURPOSE = %@",self.myLocationManager.purpose);
        //选择定位的方式为最优的状态，他又四种方式在文档中能查到
        myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //发生事件的最小距离间隔
        myLocationManager.distanceFilter = 1000.0f;
        [myLocationManager startUpdatingLocation];
        
    }
}


#pragma mark MKReverseGeocoderDelegate//ios5之前适用，需要MKReverseGeocoderDelegate
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categoryButtonClick:(UIButton *)sender
{
    if (sender.tag==1)
    {
        if(iPhone5)
        {
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX , 15, 15);

        }
        else{
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX-20 , 15, 15);

        }
        [_firstImage setImage:[UIImage imageNamed:@"icon_recommend.png"]];
        [_firstLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        [_secondImage setImage:[UIImage imageNamed:@"icon_women1.png"]];
        [_secondLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_thirdImage setImage:[UIImage imageNamed:@"icon_man1.png"]];
        [_thirdLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_forthImage setImage:[UIImage imageNamed:@"icon_facetype1.png"]];
        [_forthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_fifthImage setImage:[UIImage imageNamed:@"icon_perm1.png"]];
        [_fifthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_sixthImage setImage:[UIImage imageNamed:@"icon_color1.png"]];
        [_sixthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        
        whichDic = @"1";
        [myTableView reloadData];
    }
    else if(sender.tag==2)
    {
        if(iPhone5)
        {
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+72, 15, 15);
            
        }
        else{
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+42, 15, 15);
            
        }
        [_firstImage setImage:[UIImage imageNamed:@"icon_recommend1.png"]];
        [_firstLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_secondImage setImage:[UIImage imageNamed:@"icon_women.png"]];
        [_secondLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        [_thirdImage setImage:[UIImage imageNamed:@"icon_man1.png"]];
        [_thirdLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_forthImage setImage:[UIImage imageNamed:@"icon_facetype1.png"]];
        [_forthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_fifthImage setImage:[UIImage imageNamed:@"icon_perm1.png"]];
        [_fifthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_sixthImage setImage:[UIImage imageNamed:@"icon_color1.png"]];
        [_sixthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        whichDic = @"2";
        [myTableView reloadData];
    }
    else if(sender.tag==3)
    {
        if(iPhone5)
        {
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+72*2 , 15, 15);
            
        }
        else{
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+52*2 , 15, 15);
            
        }
        [_firstImage setImage:[UIImage imageNamed:@"icon_recommend1.png"]];
        [_firstLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_secondImage setImage:[UIImage imageNamed:@"icon_women1.png"]];
        [_secondLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_thirdImage setImage:[UIImage imageNamed:@"icon_man.png"]];
        [_thirdLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        [_forthImage setImage:[UIImage imageNamed:@"icon_facetype1.png"]];
        [_forthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_fifthImage setImage:[UIImage imageNamed:@"icon_perm1.png"]];
        [_fifthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_sixthImage setImage:[UIImage imageNamed:@"icon_color1.png"]];
        [_sixthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        whichDic = @"3";
        [myTableView reloadData];
    }
    else if(sender.tag==4)
    {
        if(iPhone5)
        {
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+71*3+1 , 15, 15);
            
        }
        else{
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+51*3+10 , 15, 15);
            
        }
        [_firstImage setImage:[UIImage imageNamed:@"icon_recommend1.png"]];
        [_firstLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_secondImage setImage:[UIImage imageNamed:@"icon_women1.png"]];
        [_secondLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_thirdImage setImage:[UIImage imageNamed:@"icon_man1.png"]];
        [_thirdLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_forthImage setImage:[UIImage imageNamed:@"icon_facetype.png"]];
        [_forthLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        [_fifthImage setImage:[UIImage imageNamed:@"icon_perm1.png"]];
        [_fifthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_sixthImage setImage:[UIImage imageNamed:@"icon_color1.png"]];
        [_sixthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        whichDic = @"4";
        [myTableView reloadData];
    }
    else if(sender.tag==5)
    {
        if(iPhone5)
        {
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+71*4+2 , 15, 15);
            
        }
        else{
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+51*4+20 , 15, 15);
            
        }
        [_firstImage setImage:[UIImage imageNamed:@"icon_recommend1.png"]];
        [_firstLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_secondImage setImage:[UIImage imageNamed:@"icon_women1.png"]];
        [_secondLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_thirdImage setImage:[UIImage imageNamed:@"icon_man1.png"]];
        [_thirdLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_forthImage setImage:[UIImage imageNamed:@"icon_facetype1.png"]];
        [_forthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_fifthImage setImage:[UIImage imageNamed:@"icon_perm.png"]];
        [_fifthLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        [_sixthImage setImage:[UIImage imageNamed:@"icon_color1.png"]];
        [_sixthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        whichDic = @"5";
        [myTableView reloadData];
    }
    else if(sender.tag==6)
    {
        if(iPhone5)
        {
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+71*5+2 , 15, 15);
            
        }
        else{
            _signImage.frame = CGRectMake(signOrigionY,signOrigionX+51*5+30 , 15, 15);
            
        }
        
        [_firstImage setImage:[UIImage imageNamed:@"icon_recommend1.png"]];
        [_firstLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_secondImage setImage:[UIImage imageNamed:@"icon_women1.png"]];
        [_secondLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_thirdImage setImage:[UIImage imageNamed:@"icon_man1.png"]];
        [_thirdLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_forthImage setImage:[UIImage imageNamed:@"icon_facetype1.png"]];
        [_forthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_fifthImage setImage:[UIImage imageNamed:@"icon_perm1.png"]];
        [_fifthLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        [_sixthImage setImage:[UIImage imageNamed:@"icon_color.png"]];
        [_sixthLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        whichDic = @"6";
        [myTableView reloadData];
    }
}
@end
