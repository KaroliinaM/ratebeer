var BREWERIES={};
BREWERIES.show=function(){
    $("#brewerytable tr:gt(0)").remove();
  var table=$("#brewerytable");
  $.each(BREWERIES.list, function (index, brewery){
    table.append('<tr>'
      +'<td>'+brewery['name'] +'</td>'
      +'<td>'+brewery['year'] +'</td>'
      +'<td>'+brewery['active']+'</td>'
      +'<td>'+brewery['beers'].length+'</td>'
    +'</tr>')
  });
};
BREWERIES.sort_by_name=function(){
  BREWERIES.list.sort(function(a, b){
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};
BREWERIES.sort_by_year=function(){
  BREWERIES.list.sort(function(a, b){
    if (b.year > a.year) return 1;
    else if (a.year >b.year) return -1;
    else return 0;
  });
};
BREWERIES.sort_by_active=function(){
  BREWERIES.list.sort(function(a, b){
    if(b.active && !a.active) return 1;
    else if (a.active && !b.active) return -1
    else return 0;
  });
};
BREWERIES.sort_by_beers=function(){
  BREWERIES.list.sort(function(a, b){
    if (b.beers.length>a.beers.length) return 1;
    else if(a.beers.length>b.beers.length) return -1;
    else return 0;
  });
};

$(document).ready(function(){
  $("#name").click(function (e){
    BREWERIES.sort_by_name();
    BREWERIES.show();
    e.preventDefault();
  });
  $("#year").click(function (e){
    BREWERIES.sort_by_year();
    BREWERIES.show();
    e.preventDefault();
  });
  $("#active").click(function (e){
    BREWERIES.sort_by_active();
    BREWERIES.show();
    e.preventDefault();
  });
  $("#beers").click(function(e){
    BREWERIES.sort_by_beers();
    BREWERIES.show();
    e.preventDefault();
  });

  $.getJSON('breweries.json', function(breweries){
    BREWERIES.list=breweries;
    BREWERIES.sort_by_active();
    BREWERIES.show();
  });
});
