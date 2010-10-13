LessJsRoutes = {

  less_json_eval: function(json){return eval('(' +  json + ')');},

  jq_defined: function(){return typeof(jQuery) != "undefined";},

  less_get_params: function(obj){
     
    if (jq_defined()) { return obj; }
    if (obj == null) {return '';}
    var s = [];
    for (prop in obj){
      s.push(prop + "=" + obj[prop]);
    }
    return s.join('&') + '';
  },

  less_merge_objects: function(a, b){
    
    if (b == null) {return a;}
    z = new Object;
    for (prop in a){z[prop] = a[prop];}
    for (prop in b){z[prop] = b[prop];}
    return z;
  },

  less_ajax: function(url, verb, params, options){
     
    if (verb == undefined) {verb = 'get';}
    var res;
    if (jq_defined()){
      v = verb.toLowerCase() == 'get' ? 'GET' : 'POST';
      if (verb.toLowerCase() == 'get' || verb.toLowerCase() == 'post'){p = LessJsRoutes.less_get_params(params);}
      else{p = LessJsRoutes.less_get_params(LessJsRoutes.less_merge_objects({'_method': verb.toLowerCase()}, params));} 
       
       
      res = jQuery.ajax(LessJsRoutes.less_merge_objects({async:false, url: url, type: v, data: p}, options)).responseText;
    } else {  
      new Ajax.Request(url, LessJsRoutes.less_merge_objects({asynchronous: false, method: verb, parameters: LessJsRoutes.less_get_params(params), onComplete: function(r){res = r.responseText;}}, options));
    }
    if (url.indexOf('.json') == url.length-5){ return LessJsRoutes.less_json_eval(res);}
    else {return res;}
  },

  less_ajaxx: function(url, verb, params, options){
     
    if (verb == undefined) {verb = 'get';}
    if (jq_defined()){
      v = verb.toLowerCase() == 'get' ? 'GET' : 'POST';
      if (verb.toLowerCase() == 'get' || verb.toLowerCase() == 'post'){p = LessJsRoutes.less_get_params(params);}
      else{p = less_get_params(LessJsRoutes.less_merge_objects({'_method': verb.toLowerCase()}, params));}
       
       
      jQuery.ajax(LessJsRoutes.less_merge_objects({ url: url, type: v, data: p, complete: function(r){eval(r.responseText)}}, options));
    } else {  
      new Ajax.Request(url, LessJsRoutes.less_merge_objects({method: verb, parameters: LessJsRoutes.less_get_params(params), onComplete: function(r){eval(r.responseText);}}, options));
    }
  },

  less_check_parameter: function(param) {
    if (param === undefined) {
      param = '';
    }
    return param;
  },
  
  less_check_path: function(path) {
    return path.replace(/\.$/m, '');
  },
  
  // rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/rails/info/properties.' + format + '');},
  rails_info_properties_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/rails/info/properties.' + format + ''), verb, params, options);},
  rails_info_properties_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/rails/info/properties.' + format + ''), verb, params, options);},
  
  // signin => /signin(.:format)
  signin_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/signin.' + format + '');},
  signin_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/signin.' + format + ''), verb, params, options);},
  signin_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/signin.' + format + ''), verb, params, options);},
  
  // admin_uploaded_file => /admin/uploaded_files/:id(.:format)
  admin_uploaded_file_path: function(id, format, verb){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/uploaded_files/' + id + '.' + format + '');},
  admin_uploaded_file_ajax: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/uploaded_files/' + id + '.' + format + ''), verb, params, options);},
  admin_uploaded_file_ajaxx: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/uploaded_files/' + id + '.' + format + ''), verb, params, options);},
  
  // edit_admin_uploaded_file => /admin/uploaded_files/:id/edit(.:format)
  edit_admin_uploaded_file_path: function(id, format, verb){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/uploaded_files/' + id + '/edit.' + format + '');},
  edit_admin_uploaded_file_ajax: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/uploaded_files/' + id + '/edit.' + format + ''), verb, params, options);},
  edit_admin_uploaded_file_ajaxx: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/uploaded_files/' + id + '/edit.' + format + ''), verb, params, options);},
  
  // new_admin_uploaded_file => /admin/uploaded_files/new(.:format)
  new_admin_uploaded_file_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/uploaded_files/new.' + format + '');},
  new_admin_uploaded_file_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/uploaded_files/new.' + format + ''), verb, params, options);},
  new_admin_uploaded_file_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/uploaded_files/new.' + format + ''), verb, params, options);},
  
  // admin_uploaded_files => /admin/uploaded_files(.:format)
  admin_uploaded_files_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/uploaded_files.' + format + '');},
  admin_uploaded_files_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/uploaded_files.' + format + ''), verb, params, options);},
  admin_uploaded_files_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/uploaded_files.' + format + ''), verb, params, options);},
  
  // password_resets => /password_resets(.:format)
  password_resets_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/password_resets.' + format + '');},
  password_resets_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/password_resets.' + format + ''), verb, params, options);},
  password_resets_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/password_resets.' + format + ''), verb, params, options);},
  
  // admin_catalog => /admin/catalog/:id(.:format)
  admin_catalog_path: function(id, format, verb){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/catalog/' + id + '.' + format + '');},
  admin_catalog_ajax: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/catalog/' + id + '.' + format + ''), verb, params, options);},
  admin_catalog_ajaxx: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/catalog/' + id + '.' + format + ''), verb, params, options);},
  
  // tree_admin_catalog_index => /admin/catalog/tree(.:format)
  tree_admin_catalog_index_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/catalog/tree.' + format + '');},
  tree_admin_catalog_index_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/catalog/tree.' + format + ''), verb, params, options);},
  tree_admin_catalog_index_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/catalog/tree.' + format + ''), verb, params, options);},
  
  // root => /(.:format)
  root_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/.' + format + '');},
  root_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/.' + format + ''), verb, params, options);},
  root_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/.' + format + ''), verb, params, options);},
  
  // edit_password_resets => /edit_password_resets/:perishable_token(.:format)
  edit_password_resets_path: function(perishable_token, format, verb){ perishable_token = LessJsRoutes.less_check_parameter(perishable_token);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/edit_password_resets/' + perishable_token + '.' + format + '');},
  edit_password_resets_ajax: function(perishable_token, format, verb, params, options){ perishable_token = LessJsRoutes.less_check_parameter(perishable_token);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/edit_password_resets/' + perishable_token + '.' + format + ''), verb, params, options);},
  edit_password_resets_ajaxx: function(perishable_token, format, verb, params, options){ perishable_token = LessJsRoutes.less_check_parameter(perishable_token);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/edit_password_resets/' + perishable_token + '.' + format + ''), verb, params, options);},
  
  // edit_admin_catalog => /admin/catalog/:id/edit(.:format)
  edit_admin_catalog_path: function(id, format, verb){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/catalog/' + id + '/edit.' + format + '');},
  edit_admin_catalog_ajax: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/catalog/' + id + '/edit.' + format + ''), verb, params, options);},
  edit_admin_catalog_ajaxx: function(id, format, verb, params, options){ id = LessJsRoutes.less_check_parameter(id);format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/catalog/' + id + '/edit.' + format + ''), verb, params, options);},
  
  // new_admin_catalog => /admin/catalog/new(.:format)
  new_admin_catalog_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/catalog/new.' + format + '');},
  new_admin_catalog_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/catalog/new.' + format + ''), verb, params, options);},
  new_admin_catalog_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/catalog/new.' + format + ''), verb, params, options);},
  
  // account => /account(.:format)
  account_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/account.' + format + '');},
  account_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/account.' + format + ''), verb, params, options);},
  account_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/account.' + format + ''), verb, params, options);},
  
  // admin_catalog_index => /admin/catalog(.:format)
  admin_catalog_index_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/catalog.' + format + '');},
  admin_catalog_index_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/catalog.' + format + ''), verb, params, options);},
  admin_catalog_index_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/catalog.' + format + ''), verb, params, options);},
  
  // signup => /signup(.:format)
  signup_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/signup.' + format + '');},
  signup_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/signup.' + format + ''), verb, params, options);},
  signup_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/signup.' + format + ''), verb, params, options);},
  
  // move_admin_catalog_index => /admin/catalog/move(.:format)
  move_admin_catalog_index_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/admin/catalog/move.' + format + '');},
  move_admin_catalog_index_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/admin/catalog/move.' + format + ''), verb, params, options);},
  move_admin_catalog_index_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/admin/catalog/move.' + format + ''), verb, params, options);},
  
  // logout => /logout(.:format)
  logout_path: function(format, verb){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_check_path('/logout.' + format + '');},
  logout_ajax: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajax(LessJsRoutes.less_check_path('/logout.' + format + ''), verb, params, options);},
  logout_ajaxx: function(format, verb, params, options){ format = LessJsRoutes.less_check_parameter(format); return LessJsRoutes.less_ajaxx(LessJsRoutes.less_check_path('/logout.' + format + ''), verb, params, options);},

}