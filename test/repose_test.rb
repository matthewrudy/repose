require 'test_helper'

require 'repose'

class ReposeTest < ActiveSupport::TestCase

  test "define" do
    base = Repose.define do
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

  test "define - nested directories" do
    base = Repose.define do
      directory "Outer" do
        directory "Inner" do
          repo "project", :git => "git@example.com:repo.git"
        end
      end
    end

    assert_equal 1, base.directories.length
    outer_dir = base.directories.first

    assert_equal "Outer", outer_dir.path
    assert_equal 1, outer_dir.directories.length

    inner_dir = outer_dir.directories.first
    assert_equal "Inner", inner_dir.path

    assert_equal 1, inner_dir.repos.length
    project_repo = inner_dir.repos.first
    assert_equal "project", project_repo.name
  end

end