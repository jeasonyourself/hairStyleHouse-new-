//
//  saleBeaspeakCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "saleBeaspeakCell.h"
#import "myShowViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation saleBeaspeakCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        headImage = [[UIImageView alloc] init];
        
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        
        
        cityLable = [[UILabel alloc] init];
        cityLable.font=[UIFont systemFontOfSize:12];
        
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        
        addressLable = [[UILabel alloc] init];
        addressLable.font=[UIFont systemFontOfSize:12];
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:cityLable];
        [self addSubview:addressLable];
        [self addSubview:timeLable];
        // Initialization code
    }
    return self;
}

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"username"];
    NSString * cityStr = [dic objectForKey:@"store_name"];
   
    NSString * addressStr = [dic objectForKey:@"store_address"];
    
    NSString * concernsStr = [dic objectForKey:@"isconcerns"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    cityLable.text =cityStr;
    addressLable.text = addressStr;
    
    timeLable.text = concernsStr;
    //    addressLable.lineBreakMode = UILineBreakModeWordWrap;
    addressLable.numberOfLines = 0;
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 15);
    cityLable.frame = CGRectMake(80, 35, 200, 15);
//    timeLable.frame = CGRectMake(80, 55, 200, 15);
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(160,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [addressStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
   
        addressLable.frame = CGRectMake(80, 55, labelsize.width, labelsize.height);
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
