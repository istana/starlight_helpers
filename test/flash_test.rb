require 'erb'
require_relative './test_helper'

class Lester
  attr_accessor :flash
  include StarlightHelpers::Flash

  def initialize
   @flash = ActionDispatch::Flash::FlashHash.new({})
  end
end

describe StarlightHelpers::Flash do
  before(:each) do
    @lester = Lester.new
  end

  it "#flash_alert" do
    @lester.flash_alert(":-O")
    assert_equal [":-O"], @lester.flash[:alert]
    assert_nil @lester.flash[:another]
  end
  
  it "#flash_notice" do
    @lester.flash_notice(";-)")
    assert_equal [";-)"], @lester.flash[:notice]
    assert_nil @lester.flash[:another]
  end
  
  it "#flash_something" do
    @lester.flash_something(:world, "I'm the best")
    @lester.flash_something(:world, "Am I good or am I good?")
    assert_equal ["I'm the best", "Am I good or am I good?"], @lester.flash[:world]
    assert_nil @lester.flash[:another]
  end
  
  it "#flash_something handles preexisting string" do
    @lester.flash[:kayla] = "<3"
    @lester.flash_something(:kayla, "^_^")
    assert_equal ["<3", "^_^"], @lester.flash[:kayla]
  end
  
  it "#display_flash without block" do
    @lester.flash_notice(";-)")
    @lester.flash_notice("8-)")
    
    result = ERB.new(<<-EOF
<%= display_flash(:notice) %>
    EOF
    # this is weird, and public method or .send doesn't work
    ).result(@lester.instance_eval { binding })
    assert_equal ";-) 8-)\n", result
    assert_nil @lester.flash[:notice]
  end
  
  it "#display_flash with the block" do
    @lester.flash_notice("hello")
    @lester.flash_notice("world")
    
    # ERB is bit weird, cannot do "_#{msg}_", becase
    # NameError: undefined local variable or method `msg'
    # must be concatenated
    template = <<-EOF
<% display_flash(:notice) do |msg| %>
<%= "_"+msg+"_" %>
<% end %>
    EOF
    result_with_block = ERB.new(template, nil, '<>').result(@lester.instance_eval { binding })
    assert_equal "_hello__world_", result_with_block
    assert_nil @lester.flash[:notice]
  end
end
