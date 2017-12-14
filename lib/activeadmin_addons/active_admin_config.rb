require 'active_admin/views/pages/base'
class ActiveAdmin::Views::Pages::Base
  private
  alias_method :original_build_page, :build_page

  def build_page
    original_build_page
    div "", id: "activeadmin_addons_data", 'data-default-select': ActiveadminAddons.default_select
  end
end
