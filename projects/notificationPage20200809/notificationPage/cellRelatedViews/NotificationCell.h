//
//  NotificationCell.h
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "TimeTagView.h"
#import "MsgSummaryView.h"
#import "TipListView.h"
#import "DetailFooterView.h"
#import "NoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationCell : UITableViewCell

-(void)setCellWithNoticeModel:(NoticeList *)notice;

@end

NS_ASSUME_NONNULL_END
