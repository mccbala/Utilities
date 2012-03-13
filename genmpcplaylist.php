<?php
if ($argv[1]=="dir") $dir=$argv[2]; else $dir=$_GET['dir'];   
$files = system('dir "'.$dir.'" /s /a:-d-h /b > C:/getfilelist.txt');
$filearray = file('C:/getfilelist.txt');
$i=1;
$playlistarray=array();
$exts=array('mkv','mp4','avi','vob','mpg','mp3');
$playlistarray[0]="MPCPLAYLIST\n";
foreach($filearray as $file) {
		if(in_array(trim(strtolower(end(explode(".",$file)))),$exts)) {
		$txt = "$i,type,0\n$i,filename,$file";
		echo nl2br($txt);
		$playlistarray[] .= $txt;
		$i++;
	}
}
file_put_contents($dir."\\".basename($dir)." - Playlist.mpcpl",$playlistarray);
unlink('C:/getfilelist.txt');
?>