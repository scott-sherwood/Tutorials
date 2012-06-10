<?php

require_once('PlistParser.php');
require_once('functions.php');

$taskID = $_POST['taskID'];
$name = $_POST['name'];

addTask($taskID,$name);
$pending_tasks = getPendingTasks();

$pp = new PlistParser();
$plist = $pp->convertIntoPlist($pending_tasks,true);
echo $plist;
