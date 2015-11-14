$(document).ready(function(){
  $("#addItem").click(function(){
    items = $("#items");
    n = items.children(".item").length;
    items.append(newItemHtml(n));
  });
});

newItemHtml = function(n){
  id = "chart_items_attributes_" + n + "_name";
  name = 'chart[items_attributes][' + n + '][name]';
  html = '<div class="item">';
  html += '<label for="' + id + '">Name</label>';
  html += '<input id="' + id + '" type="text" name="' + name + '"></input>';
  return html;
}
