//
//  MsgSummaryView.h
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MsgSummaryView : UIView

-(void)setWithTitle:(NSString *)title andContnetTip:(NSString *)contentTip andContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
