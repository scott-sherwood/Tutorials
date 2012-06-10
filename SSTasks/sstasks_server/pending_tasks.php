<?php

require_once('PlistParser.php');
require_once('functions.php');

$pending_tasks = getPendingTasks();

$pp = new PlistParser();
$plist = $pp->convertIntoPlist($pending_tasks,true);
echo $plist;
