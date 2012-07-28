module LikeButton
  def like_button(app_id, options = {})
    params = like_options_to_data_params(default_like_button_options.merge(options))
    params.merge!(class: "fb-like")

    html = "".html_safe
    html << content_tag(:div, nil, id: "fb-root")
    html << like_widgets_js_tag(app_id) unless @like_widgetized
    html << content_tag(:div, nil, params)
  end

  class << self
    attr_accessor :default_like_button_options
  end

  def default_like_button_options
    options = {
      send:    "false",
      layout:  "button_count",
      width:   "450",
      action:  "like",
      font:    "arial",
      colorscheme: "light"
    }.merge("show-faces" => "false")

    options.merge(LikeButton.default_like_button_options || {})
  end

  def like_widgets_js_tag(app_id)
    @like_widgetized = true

    js_sdk = "https://connect.facebook.net/en_US/all.js#xfbml=1&appId=#{app_id}"
    "<script src=#{js_sdk} type='text/javascript'></script>".html_safe
  end

  def like_options_to_data_params(opts)
    params = {}
    opts.each {|k, v| params["data-#{k}"] = v}
    params
  end
end
