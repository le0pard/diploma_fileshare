LeoAdminShop = {
  subnode: null,
  
  init : function(){
    this.init_global_ajax();
    this.init_catalog_tree();
    this.init_catalog_links();
  },
  init_global_ajax: function(){
    $("#loading").bind("ajaxSend", function(){
     $(this).show();
    }).bind("ajaxComplete", function(){
     $(this).hide();
    });
  },
  init_catalog_links: function(){
    if ($('#add_root_catalog').length == 0) return nil;
    
    $('#add_root_catalog').bind('click', function(event){
      $('#content').load(LessJsRoutes.new_admin_catalog_path());
      LeoAdminShop.subnode = null;
      return false;
    });
    
    $('#add_sub_catalog').bind('click', function(event){
      if (LeoAdminShop.subnode){
        $('#content').load(LessJsRoutes.new_admin_catalog_path() + "?catalog_id=" + LeoAdminShop.subnode);
      } else {
        $('#content').load(LessJsRoutes.new_admin_catalog_path() + "?catalog_id=0");
      }
      return false;
    });
    
  },
  init_catalog_tree : function(){
    if ($('#catalog_tree').length == 0) return nil;
    
      $("#catalog_tree").jstree({
      "html_data" : {
        "ajax" : {
          "url" : LessJsRoutes.tree_admin_catalog_index_path(),
          "data" : function (n) {
            return { id : n.attr ? n.attr("rel") : 0 };
          }
        }
      },
      "ui" : {
        "select_limit" : 1
      },
      "crrm" : { 
        "move" : {
        }
      },
      "dnd" : {
        "drop_target" : false,
        "drag_target" : false
      },
      "themes" : {
        "theme" : "apple",
        "url" : "/stylesheets/vendor/jstree_themes/apple/style.css",
        "dots" : true,
        "icons" : false
      },
      core : {"animation" : 0},
      plugins : [ "themes", "html_data", "ui", "crrm", "dnd" ]
    });
  
    $("#catalog_tree").bind("select_node.jstree", function(event, data) {
      var node = data.inst.get_selected();
      LeoAdminShop.subnode = node.attr('rel');
      $('#content').load(LessJsRoutes.edit_admin_catalog_path(LeoAdminShop.subnode));
      return false;
    });
  
    $("#catalog_tree").bind("move_node.jstree", function(event, data) {
      var type = data.rslt.p;
      var node = data.rslt.o;
      var ref_node = data.rslt.r;
      var new_parrent = data.rslt.np;
  
      $.get(LessJsRoutes.move_admin_catalog_index_path(), { 'node' : node.attr('rel'), 'ref_node' : ref_node.attr('rel'), 'type' : type, 'parent' : new_parrent.attr('rel')});
    });
  }
}


$(document).ready(function() {
  LeoAdminShop.init();
});