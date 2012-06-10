<?php

require_once('PlistParser.php');
require_once('functions.php');


$taskID = $_POST['taskID'];

taskCompleted($taskID);
$pending_tasks = getPendingTasks();

$pp = new PlistParser();
$plist = $pp->convertIntoPlist($pending_tasks,true);
echo $plist;
