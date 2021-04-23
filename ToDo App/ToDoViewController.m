//
//  ToDoViewController.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import "ToDoViewController.h"
#import "TaskDetailsViewController.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"
#import "Task.h"


@interface ToDoViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *search;

@end

@implementation ToDoViewController{
//    NSMutableArray *males;
    NSMutableArray<Task*>* incomingToDoArray;
    NSMutableArray<Task*>* searchArray;
    BOOL isFiltered;

    NSData *aaa;
    
    NSMutableArray *odoArray;
    
    
    
    NSMutableArray<Task*>* incomingProgressArray;

    NSData *aa;


}
- (void)viewWillAppear:(BOOL)animated{
    
    incomingToDoArray=[NSMutableArray new];
    searchArray=[NSMutableArray new];
    aaa =[NSData new];
    odoArray=[NSMutableArray new];

    aaa=[[NSUserDefaults standardUserDefaults]objectForKey:@"TODO"];
    
    NSMutableArray *arr=[NSKeyedUnarchiver unarchiveObjectWithData:aaa];
    
     for (Task *ress in arr)
    {
        [incomingToDoArray addObject:ress];
        [_toDoTabel reloadData];
       
    }
   
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        isFiltered=false;
    }

    else {
        isFiltered=true;
        searchArray =[[NSMutableArray alloc]init];
        for (int i=0 ; i<[incomingToDoArray count];i++) {

            NSRange range = [[[incomingToDoArray objectAtIndex:i] name] rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if (range.location != NSNotFound) {

                [searchArray addObject:[incomingToDoArray objectAtIndex:i]];

            }
        }

    }
     [_toDoTabel reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    isFiltered=false;
    self.search.delegate=self;
    /*
    
    incomingProgressArray=[NSMutableArray new];
    aa =[NSData new];

    aa=[[NSUserDefaults standardUserDefaults]objectForKey:@"TODO"];
    NSMutableArray *arr=[NSKeyedUnarchiver unarchiveObjectWithData:aa];
    
    NSData  *aaaa=[[NSUserDefaults standardUserDefaults]objectForKey:@"INPROGRESS"];
    odoArray=[NSKeyedUnarchiver unarchiveObjectWithData:aaaa];
    
     for (Task *ress in arr)
    {
        if(ress.reminderDate<= [NSDate date])
        {
            [arr removeObject:ress];
            //[odoArray addObject:ress];
        }
    }
    NSData *data1=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:NO error:nil];

    [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:@"TODO"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSData *data2=[NSKeyedArchiver archivedDataWithRootObject:odoArray requiringSecureCoding:NO error:nil];

    [[NSUserDefaults standardUserDefaults] setObject:data2 forKey:@"INPROGRESS"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     
     */
            
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (isFiltered) {
        return [searchArray count];

    }
    else
    return [incomingToDoArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (isFiltered) {
        // Configure the cell...
        cell.textLabel.text=[searchArray objectAtIndex:indexPath.row].name;
        if([[[searchArray objectAtIndex:indexPath.row] priority] isEqualToString:@"High"]){
            cell.imageView.image =[UIImage imageNamed:@"H.png"] ;
         }
         else if([[[searchArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Mid"]){
             cell.imageView.image =[UIImage imageNamed:@"M.png"] ;
         }
         else  if([[[searchArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Low"]){
             cell.imageView.image =[UIImage imageNamed:@"L.png"] ;
         }
            
    }
    else
    {
        // Configure the cell...
        cell.textLabel.text=[incomingToDoArray objectAtIndex:indexPath.row].name;
        if([[[incomingToDoArray objectAtIndex:indexPath.row] priority] isEqualToString:@"High"]){
            cell.imageView.image =[UIImage imageNamed:@"H.png"] ;
         }
         else if([[[incomingToDoArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Mid"]){
             cell.imageView.image =[UIImage imageNamed:@"M.png"] ;
         }
         else  if([[[incomingToDoArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Low"]){
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
    sec.data=[incomingToDoArray objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:sec animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"TODO"];
        incomingToDoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
       
        for (Task *ress in incomingToDoArray)
       {
           if ([incomingToDoArray objectAtIndex:indexPath.row].name==ress.name) {
               printf("%d",[incomingToDoArray objectAtIndex:indexPath.row].name);
               printf("%d",ress.name);
                   [incomingToDoArray removeObject:ress];

           }

       }
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:incomingToDoArray requiringSecureCoding:NO error:nil];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TODO"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [_toDoTabel reloadData];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (IBAction)navigateToAddTaskScreen:(id)sender {
    AddTaskViewController *addTask=[self.storyboard
                        instantiateViewControllerWithIdentifier:@"AddTaskViewController"];

    [self.navigationController pushViewController:addTask animated:YES];
}

@end
