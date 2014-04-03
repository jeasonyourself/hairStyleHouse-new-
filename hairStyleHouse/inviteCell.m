//
//  inviteCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "inviteCell.h"
#import "wayInforViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "inviteViewController.h"
@implementation inviteCell

@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] init];
        
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headImage.layer.masksToBounds = YES;//设为NO去试试
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        contentLable = [[UILabel alloc] init];
        contentLable.font=[UIFont systemFontOfSize:12];
        addressLable = [[UILabel alloc] init];
        addressLable.font=[UIFont systemFontOfSize:12];
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:contentLable];
        [self addSubview:addressLable];
        [self addSubview:timeLable];
        [self addSubview:cellButton];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"job"];
    NSString * contentStr = [dic objectForKey:@"money"];
    NSString * addressStr = [dic objectForKey:@"city"];
    NSString * timeStr = [dic objectForKey:@"add_time"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    contentLable.text =contentStr;
    addressLable.text = addressStr;
    timeLable.text = timeStr;
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 15);
    contentLable.frame = CGRectMake(80, 35, 200, 15);
    addressLable.frame = CGRectMake(80, 55, 100, 15);
    timeLable.frame = CGRectMake(240, 55, 80, 15);

//    cellButton.frame = CGRectMake(0, 0, 320, 80);
    cellButton.tag=index;
}
-(void)cellButtonClick:(UIButton*)_btn
{
//    [fatherView selectCell:_btn.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
