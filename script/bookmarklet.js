// using http://chris.zarate.org/bookmarkleter to convert

// new item
var url = encodeURIComponent(document.location.href),
    name = document.title;
window.open('http://learntrace.herokuapp.com/items/new?url='+url+'&name='+name, '_blank', 'toolbar=0,scrollbars=no,resizable=1,status=1,width=430,height=400');

// save as learned

var url = encodeURIComponent(document.location.href),
    name = document.title;
window.open('http://learntrace.herokuapp.com/bookmarklet/learned?url='+url+'&name='+name, '_blank', 'toolbar=0,scrollbars=no,resizable=1,status=1,width=430,height=400');
