//
//  hotTalkCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "hotTalkCell.h"
#import "hotTalkViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation hotTalkCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] init];
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:timeLable];
        [self addSubview:cellButton];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"pic"];
    NSString * nameStr = [dic objectForKey:@"content"];
    NSString * timeStr = [dic objectForKey:@"add_time"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    timeLable.text = timeStr;
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 15);
    timeLable.frame = CGRectMake(80, 55, 200, 15);
    cellButton.frame = CGRectMake(0, 0, 320, 80);
    cellButton.tag=index;
}
-(void)cellButtonClick:(UIButton*)_btn
{
    [fatherView selectCell:_btn.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
