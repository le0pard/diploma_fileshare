class Admin::CatalogController < Admin::BaseController
  
  def index
    @catalog = Catalog.new unless @catalog.nil?
  end
  
  def new
    @catalog = Catalog.new
    if request.xhr?
      if params[:catalog_id]
        unless params[:catalog_id].to_i == 0
          catalog = Catalog.find(params[:catalog_id])
          @parent_id = catalog.id
        else
          @parent_id = 0
        end
        render :partial => 'admin/catalog/add_catalog', :object => @catalog
      else
        render :partial => 'admin/catalog/add_catalog', :object => @catalog
      end
    end
  end
  
  def create
    if params[:parent_id]
      parent_catalog = Catalog.find(params[:parent_id])
      @catalog = parent_catalog.children.new(params[:catalog])
    else  
      @catalog = Catalog.new(params[:catalog])
    end
    if @catalog.save
      flash[:notice] = I18n.t("admin.catalog.flash.add_notice")
      redirect_to :action => 'edit', :id => @catalog.id
    else
      @parent_id = parent_catalog.id if defined?(parent_catalog)
      render :action => 'new'
    end
  end
  
  def edit
    @catalog = Catalog.find(params[:id])
    if request.xhr?
      render :partial => 'admin/catalog/edit_catalog', :object => @catalog
    end
  end
  
  def update
    @catalog = Catalog.find(params[:id])
    if params[:icon_delete]
      @catalog.icon = nil
    end
    if @catalog.update_attributes(params[:catalog])
      @catalog.move_to_child_of(params[:parent_id].to_i) if (params[:parent_id].to_i != @catalog.parent_id && params[:parent_id].to_i != @catalog.id)
      redirect_to :action => 'edit', :id => @catalog.id
    else
      render :action => 'edit'
    end
  end
  
  def tree
    unless params[:id].blank?
      if 0 == params[:id].to_i
        @catalog_tree = Catalog.tree
        render :layout => false
      else
        catalogs = Catalog.subtree(params[:id])
        render :partial => 'admin/catalog/subtree', :collection => catalogs
      end
    else
      render :nothing => true
    end
  end
  
  def move
    if params[:node] && params[:ref_node] && params[:type]
      catalog = Catalog.find(params[:node])
      if params[:type] == 'after'
        catalog.move_to_right_of(params[:ref_node]) unless catalog.nil?
      elsif params[:type] == 'before'
        catalog.move_to_left_of(params[:ref_node]) unless catalog.nil?
      elsif params[:type] == 'last'
        catalog.move_to_child_of(params[:parent]) unless catalog.nil?
      end
    end
    render :nothing => true
  end
  
  def destroy
    catalog = Catalog.find(params[:id])
    unless catalog.nil?
      catalog.destroy
      flash[:notice] = I18n.t("admin.catalog.flash.delete_notice")
    end
    redirect_to :action => 'index'
  end
  
end
