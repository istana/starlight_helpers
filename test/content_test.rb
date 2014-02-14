require_relative './test_helper'
require 'action_view'

class LesterHelper
  extend ActionView::Helpers::TagHelper
  extend ActionView::Helpers::UrlHelper
  extend StarlightHelpers::Content
end

describe StarlightHelpers::Content do
  it '#link_to_selected' do
    assert_equal '<a class="selected" href="#">Ahoy</a>',    
      LesterHelper.link_to_selected(true, 'Ahoy', '#')
    assert_equal '<a href="#">Ahoy</a>',    
      LesterHelper.link_to_selected(false, 'Ahoy', '#')
  end
  
  it '#render_text' do
    assert_equal 'Hello<br>world',
      LesterHelper.convert_content("Hello\nworld", 'plain')
    assert_equal "<p><em>Hello</em></p>\n",
      LesterHelper.convert_content("*Hello*", 'markdown')
    assert_equal '<font color="navy">Hello</font>',
      LesterHelper.convert_content('<font color="navy">Hello</font>', 'html')
  end
end 
