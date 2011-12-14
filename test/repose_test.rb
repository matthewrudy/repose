require 'test_helper'

require 'repose'

class ReposeTest < ActiveSupport::TestCase

  test "define" do
    base = Repose::Base.define do
      directory "Rails" do
        repo "core", :git => "https://github.com/rails/rails.git"
        repo "my-fork", :git => "git@github.com:me/rails.git"
      end
    end

    assert_equal 1, base.directories.length
    rails_dir = base.directories.first

    assert_equal "Rails", rails_dir.path
    assert_equal 2, rails_dir.repos.length

    core, myfork = rails_dir.repos
    assert_equal "core", core.name
    assert_equal "my-fork", myfork.name
  end

end