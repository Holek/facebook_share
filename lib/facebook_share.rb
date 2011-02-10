module FacebookShare

  def facebook_share_once(app_id, params = {})
    facebook_script_tags app_id, facebook_share('.fb_share', params)
  end

  def facebook_share(selector, params = {})
    available_params = {
      :display => "popup"
    }.merge(params)

    script = <<-JS
$("#{selector}").unbind("click.facebook_share").bind("click.facebook_share",function () {
    FB.ui(
    {
      method: \'stream.publish\'
      #{build_params(available_params)}
    });
    return false;
  });
JS
    script
  end

  def facebook_script_tags(app_id, initial_script = "")
    script = <<-JS
<script type="text/javascript" src="https://connect.facebook.net/de_DE/all.js"></script>
<script type="text/javascript">
/* <![CDATA[ */
FB.init({appId:"#{app_id}", xfbml : true});
#{initial_script}
/* ]]> */
</script>
JS
    script
  end

  private
    def build_params(available_params)
      script = ""
      available_params.each do |key, value|
        if value
          value_sanitized = value.gsub(/"/, '\"')
          script << ", #{key}: \"#{value_sanitized}\""
        end
      end
      script
    end
end
