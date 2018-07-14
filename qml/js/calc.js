var array = [0,0,0,0,0]
var lastSin
var lastCos
var smoothingFactor = 0.9

function smoothout(azi) {
    //if (last < azi - 100 || last > azi + 100) array = [azi,azi,azi,azi,azi];
    //var tem = data
    //Math.atan2(Math.sin(azi),cos(azi)) = azi

    lastSin = smoothingFactor * lastSin + (1-smoothingFactor) * Math.sin(azi)
    lastCos = smoothingFactor * lastCos + (1-smoothingFactor) * Math.cos(azi)

    var azim = Math.atan2(lastSin, lastCos)

    console.log(Math.sin(azi)+ " - "+Math.cos(azi))

    array.shift()
    array.push(azim)

    var total = 0,i;
    for (i = 0; i < array.length; i += 1) {
        total += array[i]
        //if (array[i] > 0) total += array[i]; else total -= array[i];
    }
    //data = tem
  //  console.log("******** "+ total / array.length+" ---- "+array)
//    last = azi
    return total / array.length;
}
