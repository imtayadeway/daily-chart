$(document).ready(function() {
  $("#addItem").click(function(){
    addItem(getItems().length);
  });

  $(document.body).on("click", ".removeItem", function(){
    removeItem(indexOfItemToRemove($(this).attr("id")));
  });
});

addItem = function(n) {
  $("#items").append(newItemHtml(n));
}

removeItem = function(n) {
  values = getItemValues()
  values.splice(n, 1);
  rebuildRemainingItems(values);
}

getItemValues = function() {
  return getItems().map(function() {
    return $(this).find("input").attr("value");
  }).get();
}

rebuildRemainingItems = function(values) {
  items = $("#items")
  items.empty();
  for (i = 0; i < values.length; i++) {
    items.append(newItemHtml(i, values[i]));
  }
}

indexOfItemToRemove = function(id) {
  parts = id.split("_");
  return Number(parts[parts.length - 1]);
}

getItems = function() {
  return $("#items").children(".item");
}

getItemValue = function(index) {
  result = getRawItemValue(index);
  if (result === undefined) {
    return "";
  } else {
    return result;
  }
}

getRawItemValue = function(index) {
  return $("#" + buildItemInputId(index)).attr("value");
}

buildItemInputId = function(index) {
  return "chart_items_attributes_" + index + "_name";
}

buildItemInputName = function(index) {
  return 'chart[items_attributes][' + index + '][name]';
}

buildItemLabelName = function(index) {
  return "chart_items_attributes_" + index + "_" + (index + 1);
}

newItemHtml = function(n, value) {
  id = buildItemInputId(n);
  name = buildItemInputName(n);
  label = buildItemLabelName(n);

  html = '<div class="item" id="item_' + n + '">';
  html += '<label for="' + label + '">' + (n + 1) + '</label>';
  if (value) {
    html += '<input id="' + id + '" type="text" name="' + name + '" value="' + value + '">';
  } else {
    html += '<input id="' + id + '" type="text" name="' + name + '" value="">';
  }
  html += '<button type="button" class="removeItem" id="remove_item_' + n + '">';
  html += '<span class="glyphicon glypicon-remove"></span>'
  html += "</button>";
  html += "</div>";
  return html;
}
