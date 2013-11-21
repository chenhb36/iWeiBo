//
//  iWeiBoFindUserViewController.h
//  iWeiBo
//
//  Created by Alaysh on 11/18/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iWeiBoEngine;
@interface iWeiBoFindUserViewController : UIViewController
/// 网络引擎
@property(nonatomic,strong)iWeiBoEngine *iweiBoEngine;
@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property(nonatomic,strong)IBOutlet UISearchBar *searchBar;
@end
