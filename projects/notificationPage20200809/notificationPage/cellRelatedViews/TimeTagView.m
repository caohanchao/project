//
//  TimeTagView.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import "TimeTagView.h"

@interface TimeTagView ()

@property(nonatomic, strong) UILabel *timeLabel;

@end

@implementation TimeTagView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.timeLabel];
        [self setConstraintForTimeTagView];
    }
    
    return self;
}

-(UILabel *)timeLabel{ 
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _timeLabel.text = @"今天 12:30";  // Fake data
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor systemGray2Color];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

-(void)setConstraintForTimeTagView{
    [self.timeLabel sizeToFit];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.center);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

-(void)setWithTime:(NSString *)time{
    NSLog(@"Setting with: %@", time);
    
    self.timeLabel.text = time;
}

-(void)calculateTimeTagWith:(long)date{
    NSLog(@"Reserved for dateTag calculation");
}


@end
