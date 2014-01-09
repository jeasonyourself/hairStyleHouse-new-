//
//  findStyleViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKPlacemark.h>
#import "findStyleDetailViewController.h"
#import "hairStyleCategory.h"
#import "hairStyleIconCell.h"

#define signOrigionX 103
#define signOrigionY 70
@interface findStyleViewController : UIViewController<CLLocationManagerDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView * backView;

    
    UITableView * myTableView;
    NSString * whichDic;
    NSArray * firstArr;
    NSArray * secondArr;
    NSArray * thirdArr;
    NSArray * forthArr;
    NSArray * fifthArr;
    NSArray * sixthArr;

    CLLocationManager *locationManager;
    findStyleDetailViewController * findStyleDetail;
    BOOL showLocalSuccess;
}

@property(nonatomic,strong)IBOutlet UIButton * firstButton;
@property(nonatomic,strong)IBOutlet UIButton * secondButton;
@property(nonatomic,strong)IBOutlet UIButton * thirdButton;
@property(nonatomic,strong)IBOutlet UIButton * forthButton;
@property(nonatomic,strong)IBOutlet UIButton * fifthButton;
@property(nonatomic,strong)IBOutlet UIButton * sixthButton;

@property(nonatomic,strong)IBOutlet UIImageView * firstImage;
@property(nonatomic,strong)IBOutlet UIImageView * secondImage;
@property(nonatomic,strong)IBOutlet UIImageView * thirdImage;
@property(nonatomic,strong)IBOutlet UIImageView * forthImage;
@property(nonatomic,strong)IBOutlet UIImageView * fifthImage;
@property(nonatomic,strong)IBOutlet UIImageView * sixthImage;

@property(nonatomic,strong)IBOutlet UILabel * firstLable;
@property(nonatomic,strong)IBOutlet UILabel * secondLable;
@property(nonatomic,strong)IBOutlet UILabel * thirdLable;
@property(nonatomic,strong)IBOutlet UILabel * forthLable;
@property(nonatomic,strong)IBOutlet UILabel * fifthLable;
@property(nonatomic,strong)IBOutlet UILabel * sixthLable;

@property(nonatomic,strong)IBOutlet UIImageView * signImage;//箭头
- (IBAction)categoryButtonClick:(UIButton *)sender;
-(void)selectImage:(NSInteger)_index;

@end
