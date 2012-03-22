<?php
	function generatePassword($length=8) {
		$alphanum = explode(',','a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,q,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,Q,Y,Z,0,1,2,3,4,5,6,7,8,9,%,^,&,@,!,_');
		$pwd='';
		$l = $length;
		$selected = array();
		while ($l>0) {
			$seed = mt_rand(0,count($alphanum)-1);
			if ($length<count($alphanum) && in_array($seed,$selected)) continue;
			$pwd .= $alphanum[$seed];
			$l--;
			$selected[] = $seed;
		}
		return $pwd;
	}
	
	$length = !isset($_REQUEST['l']) ? 8 : $_REQUEST['l'];
	echo generatePassword($length);
	
?>