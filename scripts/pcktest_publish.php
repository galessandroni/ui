<?php
$_SERVER['DOCUMENT_ROOT'] = realpath("scripts");
define('SERVER_ROOT',$_SERVER['DOCUMENT_ROOT']);

include_once(SERVER_ROOT."/../classes/publishmanager.php");
$pm = new PublishManager();

// homepage
$pm->TopicInit(0);
$pm->JobExecute(array('id_type'=>'11'),0,FALSE);

// sitemap
$pm->TopicInit(0);
$pm->Error404();
$pm->SiteMap();
?>
