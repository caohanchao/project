//
//  TipListView.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#define TITLE_WIDTH @100
#define CONTENT_WIDTH_FLOAT 300.00



#import "TipListView.h"

@interface TipListView ()

@end


@implementation TipListView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        CALayer *seperator = [CALayer layer];
        [seperator setFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
        [seperator setBackgroundColor:[UIColor systemGray6Color].CGColor];
        [self.layer addSublayer:seperator];
        
    }
    return self;
}

-(void)setWithArray:(NSArray *)arr{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];  // remove all subviews
    UILabel *formerTitle;
    for(int i = 0; i < arr.count; i++){
        TipList *item = [arr objectAtIndex:i];
        UILabel *title = [[UILabel alloc] init];
        title.text = item.title;
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor systemGray2Color];
        [self addSubview:title];
        UILabel *content = [[UILabel alloc] init];
        content.text = item.desc;
        content.font = [UIFont systemFontOfSize:15];
        content.textColor = [UIColor blackColor];
        [self addSubview:content];
        
        if([item.title isEqualToString:@"积分抵扣"]){
            title.textColor = [UIColor redColor];
            content.textColor = [UIColor redColor];
        }
        
        if(i == 0){
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(10);
                make.left.equalTo(self.mas_left).offset(5);
                make.width.mas_equalTo(TITLE_WIDTH);
                make.height.mas_equalTo(content.mas_height);
            }];
        }
        else{
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(formerTitle.mas_bottom).offset(10);
                make.left.equalTo(formerTitle.mas_left);
                make.width.mas_equalTo(TITLE_WIDTH);
                make.height.mas_equalTo(content.mas_height);
            }];
        }
        [content sizeThatFits:CGSizeMake(CONTENT_WIDTH_FLOAT, MAXFLOAT)];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_top);
            make.left.equalTo(title.mas_right);
        }];
        formerTitle = title;
    }
    
}
@end
