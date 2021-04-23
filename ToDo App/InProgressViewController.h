//
//  InProgressViewController.h
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController
 <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *inProgressTabel;


@end

NS_ASSUME_NONNULL_END
