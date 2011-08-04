require File.expand_path(File.dirname(File.dirname(__FILE__)) + '/spec_helper')

describe FacebookShare do
  include FacebookShare

  describe "building params" do
    before(:all) do
      @options = {
        :app_id => "123123123",

        :selector => "#some_fancy > .selector",
        :display => "popup",
        :link => "http://railslove.com/",
        :caption => "Railslove",
        
        :status => "true",
        :xfbml => "true",
        :cookie => "false"
      }
    end
    context "when not for_init" do
      subject { build_params(@options) }

      it { should_not match(/app_id/) }
      it { should_not match(/cookies/) }
      it { should_not match(/xfbml/) }

      it { should match(/display: "popup"/) }
      it { should match(/link: "http:\/\/railslove.com\/"/) }
      it { should match(/caption: "Railslove"/) }

      it { should_not match(/selector: "/) }
    end

    context "when for_init" do
      subject { build_params(@options, true) }

      it { should_not match(/app_id/) }
      it { should match(/cookie: "false"/) }
      it { should match(/xfbml: "true"/) }

      it { should_not match(/display: "popup"/) }
      it { should_not match(/link: "http:\/\/railslove.com\/"/) }
      it { should_not match(/caption: "Railslove"/) }

      it { should_not match(/selector: "/) }
    end
  end

  describe "building params with _js" do
    before(:all) do
      @options = {
        :app_id => "123123123",

        :selector => "#some_fancy > .selector",
        :display => "popup",
        :link => "http://railslove.com/",
        :link_js => "some_js_url",
        :caption_js => %Q("Railslove " + is_the + " best"),
        
        :status => "true",
        :xfbml => "true",
        :cookie => "false"
      }
    end
    context "when not for_init" do
      subject { build_params(@options) }

      it { should_not match(/app_id/) }
      it { should_not match(/cookies/) }
      it { should_not match(/xfbml/) }

      it { should match(/display: "popup"/) }
      it { should match(/link: some_js_url/) }
      it { should match(/caption: "Railslove " \+ is_the \+ " best"/) }

      it { should_not match(/selector: "/) }
    end

    context "when for_init" do
      subject { build_params(@options, true) }

      it { should_not match(/app_id/) }
      it { should match(/cookie: "false"/) }
      it { should match(/xfbml: "true"/) }

      it { should_not match(/display: "popup"/) }
      it { should_not match(/link: some_js_url/) }
      it { should_not match(/caption: "Railslove " \+ is_the \+ " best"/) }

      it { should_not match(/selector: "/) }
    end
  end

  describe "creating init script" do
    context "when vanilla locale" do
      subject { facebook_connect_js_tag( :locale => "en_US" ) }

      it { should match(/\/en_US\/all\.js/) }
      it { should_not match(/\/en\/all\.js/) }
    end

    context "when shortened locale" do
      subject { facebook_connect_js_tag( :locale => "en" ) }

      it { should match(/\/en_EN\/all\.js/) }
      it { should_not match(/\/en\/all\.js/) }
    end

    context "when shortened locale 2" do
      subject { facebook_connect_js_tag( :locale => "pl" ) }

      it { should match(/\/pl_PL\/all\.js/) }
      it { should_not match(/\/pl\/all\.js/) }
    end
  end

  describe "using this JavaScript framework: " do
    context "Dojo" do
      subject { facebook_share_once( :selector => ".fb_share", :framework => :dojo ) }

      it { should match(/dojo\.query\(".fb_share"\)/) }
      it { should_not match(/\$\(".fb_share"\)/) }
    end

    context "jQuery" do
      subject { facebook_share_once( :selector => ".fb_share", :framework => :jquery ) }

      it { should match(/\$\(".fb_share"\)/) }
      it { should_not match(/dojo\.query\(".fb_share"\)/) }
    end

    context "jQuery with a defined function" do
      subject { facebook_share_once( :selector => ".fb_share", :framework => :jquery, :jquery_function => "$j" ) } # $j is used on Wikimedia projects      
 
      it { should match(/\$j\(".fb_share"\)/) }
      it { should_not match(/\$\(".fb_share"\)/) }
      it { should_not match(/dojo\.query\(".fb_share"\)/) }
    end
  end
end
