function dateConversion(date,flag) {
    const arr = date.split('T');
    const d = arr[0];
    const darr = d.split('-');
	
	if(flag==0){
		const dd =
		  parseInt(darr[0]) +
		  '-' +
		  parseInt(darr[1]) +
		  '-' +
		  parseInt(darr[2]) +
		  ' '
		return dd;
	}else if(flag==1){
		const t = arr[1];
		const tarr = t.split('.000');
		const marr = tarr[0].split(':');
		
		const dd =
		  parseInt(darr[0]) +
		  '-' +
		  parseInt(darr[1]) +
		  '-' +
		  parseInt(darr[2]) +
		  ' ' +
		  parseInt(marr[0]) +
		  ':' +
		  parseInt(marr[1]) +
		  '0:' +
		  parseInt(marr[2])+'0';
		return dd;
	}
}

export {
 	dateConversion
}
