//
//  HRChatCell.m
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "HRChatCell.h"
#import "Message.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

#define RMarginSize 5
#define RBtnX 70
#define RIconSide 50

@implementation HRChatCell

- (void)awakeFromNib
{
    _msgButton.titleLabel.numberOfLines = 0;
    _msgButton.titleLabel.font = [UIFont systemFontOfSize:RChatFontSize];
    picImage = [[UIImageView alloc] init];
    [_msgButton addSubview: picImage];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = _msgButton.frame;
    rect.size.height = self.bounds.size.height - 2*RMarginSize;
    _msgButton.titleEdgeInsets = UIEdgeInsetsMake( -160, -_msgButton.titleLabel.bounds.size.width-50, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）

    _msgButton.frame = rect;
}

- (void)bindMessage:(NSDictionary *)_dic and: (NSDictionary *)lastDic
{
//    UIImage *headerImage;
    UIImage *normalImage;
    UIImage *highlightedImage;
    
    CGRect iconRect = _headerView.frame;
    CGRect btnRect = _msgButton.frame;

    UIEdgeInsets insets;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([[_dic objectForKey:@"from_id"] isEqualToString:appDele.uid])
    {
        [_headerView setImageWithURL:[NSURL URLWithString:[lastDic objectForKey:@"my_head_photo"]]];
        normalImage = [UIImage imageNamed:@"mychat_normal"];
        highlightedImage = [UIImage imageNamed:@"mychat_focused"];
        
        iconRect.origin.x = RMarginSize;
        btnRect.origin.x = RBtnX;
        
        insets = UIEdgeInsetsMake(0, 20, 0, 30);
    }
    else
    {
        [_headerView setImageWithURL:[NSURL URLWithString:[lastDic objectForKey:@"ta_head_photo"]]];
        normalImage = [UIImage imageNamed:@"other_normal"];
        highlightedImage = [UIImage imageNamed:@"other_focused"];
        
        iconRect.origin.x = self.bounds.size.width - RMarginSize - RIconSide;
        btnRect.origin.x = self.bounds.size.width - iconRect.origin.x - RMarginSize;
        
        insets = UIEdgeInsetsMake(0, 30, 0, 30);
    }
    _headerView.frame = iconRect;
//    _headerView.image = headerImage;
    
    normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width*0.5 topCapHeight:normalImage.size.height*0.6];
    highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:highlightedImage.size.width*0.5 topCapHeight:highlightedImage.size.height*0.6];
    
    [_msgButton setContentEdgeInsets:insets];
    _msgButton.frame = btnRect;
    [_msgButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_msgButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [_msgButton setTitle:[_dic objectForKey:@"content"] forState:UIControlStateNormal];
    if ([[_dic objectForKey:@"pic"] isEqualToString:@""])
    {
        
    }
    else
    {
        //设置title的字体居中
        [picImage setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"pic"]]];
        
        picImage.frame = CGRectMake(0, 150, 150, 150);
    }

}

@end
