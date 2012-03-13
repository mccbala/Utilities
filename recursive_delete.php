<?php

$files = getfiles($_REQUEST['dir']);
// echo '<pre>'.print_r($files,true).'</pre>';
delfiles($files);

function getfiles($dir) {
	if (!is_dir($dir)) die('Not a directory!');
	$files = array();
	foreach (scandir($dir) as $file) {
		if ($file=='.' || $file=='..') continue;
		$files[] = $dir.'/'.$file;
		if (is_dir($dir.'/'.$file))
			$files += array_merge($files,getfiles($dir.'/'.$file));
	}
	return $files;
}

function delfiles($files) {
	rsort($files,SORT_STRING);
	foreach($files as $file) {
		if (!is_dir($file)) {
			if (unlink($file)) 
				echo 'Deleted file: '.$file.'<br/>'; 
			else  
				echo 'Unable to delete file: '.$file.'<br/>';
		}
	}
	rsort($files,SORT_STRING);
	foreach($files as $file) {
		if (is_dir($file)) {
			if (rmdir($file)) 
				echo 'Deleted folder: '.$file.'<br/>';
			else 
				echo 'Unable to delete folder: '.$file.'<br/>';
		}
	}
}
?>