<?php

function getPendingTasks(){
    $pending_tasks = array();
    
    $link = mysql_connect('<server>', '<username>', '<password>');
    if (!$link) {
        die('Could not connect: ' . mysql_error());
    }
    mysql_select_db("my_tasks");
    $query = "SELECT taskID, name, complete FROM tasks WHERE complete=false";
    $result = mysql_query($query);


    while ($row = mysql_fetch_assoc($result)) {
        $task = array();
        $task["taskID"] = $row['taskID']; 
        $task["name"] = $row['name'];
        array_push($pending_tasks,$task);
    }

    
    mysql_close($link);
    
    return $pending_tasks;
}

function taskCompleted($taskID){
     $link = mysql_connect('<server>', '<username>', '<password>');
    if (!$link) {
        die('Could not connect: ' . mysql_error());
    }
    mysql_select_db("my_tasks");
    $query = "UPDATE tasks SET complete=true WHERE taskID='".$taskID."'";    
    mysql_query($query);
    mysql_close($link);
}


function addTask($taskID,$name){
      $link = mysql_connect('<server>', '<username>', '<password>');
    if (!$link) {
        die('Could not connect: ' . mysql_error());
    }
    mysql_select_db("my_tasks");
    $query = "INSERT INTO tasks (taskID, name, complete) VALUES ('$taskID', '$name', 'false')";    
    mysql_query($query);
    mysql_close($link);

}
