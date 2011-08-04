module FacebookShare
  INIT_PARAMS = %w(status cookie xfbml)
  REMOVE_PARAMS = %w(app_id selector status cookie xfbml locale framework jquery_function)
  
  class << self
    attr_accessor :default_facebook_share_options
  end

  def default_facebook_share_options
    # usually you might want to provide your own link anyway
    if defined? request
      link = request.url
    else
      link = "http://railslove.com"
    end
    {
      :app_id => "0",
      
      :framework => :jquery,
      :jquery_function => "$",

      :selector => ".fb_share",
      :link => link,
      :locale => "en_US",
      :display => "popup"
    }.merge(FacebookShare.default_facebook_share_options || {})
  end

  def facebook_share_once(options = {})
    facebook_script_tags options, facebook_share( options )
  end

  def facebook_share_code(options = {})
    options = default_facebook_share_options.merge(options)
    <<-JS
  FB.ui({method: 'stream.publish'#{build_params(options)}});
  return false;
JS
  end

  def facebook_share(options = {})
    options = default_facebook_share_options.merge(options)
    script = ""
    case options[:framework]
    when :dojo
      script << <<-JS
if (typeof ___facebook_share_evt != "undefined") dojo.disconnect(___facebook_share_evt);
var ___facebook_share_obj = dojo.query("#{options[:selector]}")
  , ___facebook_share_evt = dojo.connect(___facebook_share_obj, 'onclick', null, function(evt) {
#{facebook_share_code(options)}
});
JS
    else # default to jquery
      script << <<-JS
#{options[:jquery_function]}("#{options[:selector]}").unbind("click.facebook_share").bind("click.facebook_share",function () {
#{facebook_share_code(options)}
});
JS
    end
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
    options[:locale] = "#{options[:locale]}_#{options[:locale].upcase}" if /^[a-z]{2}$/.match(options[:locale])
    html_safe_string("<script type=\"text/javascript\" src=\"https://connect.facebook.net/#{options[:locale]}/all.js\"></script>")
  end

  def facebook_init_script(options = {})
    options = default_facebook_share_options.merge(options)
    params = build_params options, true
    html_safe_string("FB.init({appId:\"#{options[:app_id]}\"#{params}});")
  end

  private
    def build_params(options, for_init = false)
      script = ""
      options.each do |key, value|
        # if it's for init script, include only status, cookie and xfbml
        # if it's for stream.publish, include all except for initial
        should_add_param = ( for_init ) ? FacebookShare::INIT_PARAMS.include?(key.to_s) : !(FacebookShare::REMOVE_PARAMS.include?(key.to_s))
        
        if key.to_s !~ /_js$/ and options[(key.to_s + "_js").to_sym]
          should_add_param = false
        end

        if value && should_add_param
          inserted_key = key.to_s
          inserted_value = value
          
          if inserted_key =~ /_js$/
            inserted_key = inserted_key[0, inserted_key.length - 3]
          else
            value_sanitized = inserted_value.to_s.gsub(/"/, '\"')
            inserted_value = %Q("#{value_sanitized}")
          end
          
          script << %Q(, #{inserted_key}: #{inserted_value})
        end
      end
      script
    end

    def html_safe_string(str)
      @use_html_safe ||= "".respond_to?(:html_safe)
      @use_html_safe ? str.html_safe : str
    end
end
