# Timestamp


block.timestamp

<br/>
moment

const time = moment.unix(1331300839)
time.toString()



#Another Way 
>const date = await provider.getBlock(100004).timestamp
1469021581
> var date1 = new Date(date*1000);
 undefined
>console.log(date1.toUTCString())
 Tue, 06 Dec 2016 09:32:13 UTC
