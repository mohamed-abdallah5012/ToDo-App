//
//  InProgressViewController.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import "InProgressViewController.h"

#import "TaskDetailsViewController.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"
#import "Task.h"

@interface InProgressViewController ()

@end
@implementation InProgressViewController{
//    NSMutableArray *males;
    NSMutableArray<Task*>* incomingProgressArray;

    NSData *aaa;
    
    BOOL isSorted;
    NSMutableArray<Task*>* high;
    NSMutableArray<Task*>* low;
    NSMutableArray<Task*>* mid;



}
- (void)viewWillAppear:(BOOL)animated{
    
    
   
    
}
- (IBAction)sort:(id)sender {
    isSorted=true;
    NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"INPROGRESS"];
    incomingProgressArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
    high=[NSMutableArray new];
    mid=[NSMutableArray new];
    low=[NSMutableArray new];
    for(Task *t in incomingProgressArray)
    {
        if([t.priority isEqualToString:@"High"])
            [ high addObject:t];
        
        if([t.priority isEqualToString:@"Mid"])
                [ mid addObject:t];
        
        if([t.priority isEqualToString:@"Low"])
                    [ low addObject:t];
    }
    [_inProgressTabel reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
        
    isSorted=false;
    
    incomingProgressArray=[NSMutableArray new];
    
    
    aaa =[NSData new];

    aaa=[[NSUserDefaults standardUserDefaults]objectForKey:@"INPROGRESS"];
    
    NSMutableArray *arr=[NSKeyedUnarchiver unarchiveObjectWithData:aaa];
    
     for (Task *ress in arr)
    {
        [incomingProgressArray addObject:ress];
        [_inProgressTabel reloadData];
       
    }

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if (isSorted) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    NSInteger *mmm=0;
    if (isSorted) {
        switch (section) {
            case 0:
                mmm=[high count];
                break;
            case 1:
                mmm=[mid count];
                break;
            case 2:
                mmm=[low count];
                break;
            default:
                break;
        }
    }
    else
        mmm=[incomingProgressArray count];
    return mmm;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleHeader=@"";
    if (isSorted) {
        switch (section) {
            case 0:
                titleHeader=@"High Section";
                break;
            case 1:
                titleHeader=@"Mid Section";
                break;
            case 2:
                titleHeader=@"Low Section";
                break;
                
            default:
                break;
        }
    }
    else
    {
        titleHeader=@"";
    }
    return titleHeader;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (isSorted) {
        switch (indexPath.section) {
            case 0:
                // Configure the cell...
                cell.textLabel.text=[high objectAtIndex:indexPath.row].name;
                cell.imageView.image =[UIImage imageNamed:@"H.png"] ;
                 
                break;
            case 1:
                // Configure the cell...
                cell.textLabel.text=[mid objectAtIndex:indexPath.row].name;
                cell.imageView.image =[UIImage imageNamed:@"M.png"] ;
                break;
            case 2:
                // Configure the cell...
                cell.textLabel.text=[low objectAtIndex:indexPath.row].name;
                cell.imageView.image =[UIImage imageNamed:@"L.png"] ;
                break;
                
            default:
                break;
        }
    }
    else
    {
        // Configure the cell...
        cell.textLabel.text=[incomingProgressArray objectAtIndex:indexPath.row].name;
        if([[[incomingProgressArray objectAtIndex:indexPath.row] priority] isEqualToString:@"High"]){
            cell.imageView.image =[UIImage imageNamed:@"H.png"] ;
         }
         else if([[[incomingProgressArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Mid"]){
             cell.imageView.image =[UIImage imageNamed:@"M.png"] ;
         }
         else  if([[[incomingProgressArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Low"]){
             cell.imageView.image =[UIImage imageNamed:@"L.png"] ;
         }
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskDetailsViewController *sec=[self.storyboard
                        instantiateViewControllerWithIdentifier:@"TaskDetailsViewController"];
    sec.data=[incomingProgressArray objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:sec animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"INPROGRESS"];
        incomingProgressArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
       
        for (Task *ress in incomingProgressArray)
       {
           if ([incomingProgressArray objectAtIndex:indexPath.row].name==ress.name) {
               printf("%d",[incomingProgressArray objectAtIndex:indexPath.row].name);
               printf("%d",ress.name);
                   [incomingProgressArray removeObject:ress];

           }

       }
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:incomingProgressArray requiringSecureCoding:NO error:nil];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"INPROGRESS"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [_inProgressTabel reloadData];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
@end
