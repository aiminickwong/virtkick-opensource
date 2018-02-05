module MachinesHelper
  def power_action href, classes = '', is_button = true, &block
    btn_classes = is_button ? 'btn btn-default' : nil
    link_to href, method: :post, class: "action #{classes} #{btn_classes}", &block
  end
end
