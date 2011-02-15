module FacebookShare

  INIT_PARAMS = %w(status cookie xfbml)
  REMOVE_PARAMS = %w(app_id selector status cookie xfbml locale)

  class << self
    attr_accessor :default_facebook_share_options
  end

  def default_facebook_share_options
    {:app_id => "0", :selector => ".fb_share", :url => request.url, :locale => "en_US", :display => "popup"}
    #.merge(FacebookShare.default_facebook_share_options || {})
  end

  def facebook_share_once(options = {})
    facebook_script_tags options, facebook_share( options )
  end

  def facebook_share(options = {})
    options = default_facebook_share_options.merge(options)
    script = <<-JS
$("#{selector}").unbind("click.facebook_share").bind("click.facebook_share",function () {
  FB.ui({method: \'stream.publish\'#{build_params(options)}});
  return false;
});
JS
    script
  end

  def facebook_script_tags(options = {}, initial_script = "")
    options = default_facebook_share_options.merge(options)
    script = <<-JS
#{facebook_connect_js_tag(options)}
<script type="text/javascript">
/* <![CDATA[ */
#{facebook_init_script(options)}
#{initial_script}
/* ]]> */
</script>
JS
    html_safe_string(script)
  end

  def facebook_connect_js_tag(options = {})
    options = default_facebook_share_options.merge(options)
    html_safe_string("<script type=\"text/javascript\" src=\"https://connect.facebook.net/#{default_facebook_share_options.merge(options)[:locale]}/all.js\"></script>")
  end

  def facebook_init_script(options = {})
    options = default_facebook_share_options.merge(options)
    params = build_params options, true
    html_safe_string("FB.init({appId:\"#{options[:app_id]}\"#{params}});")
  end
	
  def build_params(options, for_init = false)
    script = ""
    options.each do |key, value|
      param_check = ( for_init ) ? INIT_PARAMS.include?(key) : !(REMOVE_PARAMS.include?(key))
                                   # if it's for init script, include only status, cookie and xfbml
                                                              # if it's for stream.publish, include all except for initial
      if value && param_check
        value_sanitized = value.gsub(/"/, '\"')
        script << ", #{key}: \"#{value_sanitized}\""
      end
    end
    script
  end

  def html_safe_string(str)
    @use_html_safe ||= "".respond_to?(:html_safe)
    @use_html_safe ? str.html_safe : str
  end
end
