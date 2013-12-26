//
//  wayDetailCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "wayDetailCell.h"
#import "commentViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

@implementation wayDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       
        headImage = [[UIImageView alloc] init];
       
        nameLable= [[UILabel alloc] init];
        contentLable= [[UILabel alloc] init];
        
        
        
       
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:contentLable];
       
        
        // Initialization code
    }
    return self;
}
-(void)setFirstCell:(NSDictionary * )_dic
{

    NSString* contentStr = [_dic  objectForKey:@"title"];
    contentLable.text=contentStr;
    contentLable.font = [UIFont systemFontOfSize:16];
    contentLable.numberOfLines = 0;
    UIFont *font = [UIFont systemFontOfSize:16.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(280,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    contentLable.frame = CGRectMake(20, 10, 280, labelsize.height);
    
    NSString* nameStr = [_dic  objectForKey:@"add_time"];
    nameLable.text=nameStr;
    nameLable.font = [UIFont systemFontOfSize:12];
    nameLable.frame = CGRectMake(110, 10+labelsize.height, 100, 20);
    headImage.frame = CGRectMake(0, 0, 0, 0);
    
}
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index
{
    NSString* headStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"image"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.frame = CGRectMake(90, 5, 140, 200);

    
    NSString* contentStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"content"];
    contentLable.text=contentStr;
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.numberOfLines = 0;

    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(280,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    contentLable.frame = CGRectMake(20, 220, 280, labelsize.height);
    
    nameLable.frame = CGRectMake(0, 0, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
