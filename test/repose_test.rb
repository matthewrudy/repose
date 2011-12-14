require 'test_helper'

require 'repose'

class ReposeTest < ActiveSupport::TestCase

  test "define" do
    definition = Repose.define do
      directory "Rails" do
        git "core", :url=> "https://github.com/rails/rails.git"
        git "my-fork", :url => "git@github.com:me/rails.git"
      end
    end

    dsl = definition.dsl
    assert_equal 1, dsl.directories.length
    rails_dir = dsl.directories.first

    assert_equal "Rails", rails_dir.path
    assert_equal 2, rails_dir.repos.length

    core, myfork = rails_dir.repos
    assert_equal "core", core.name
    assert_equal "my-fork", myfork.name
  end

  test "define - nested directories" do
    definition = Repose.define do
      directory "Outer" do
        directory "Inner" do
          git "InnerProject", :url => "git@example.com:inner.git"
        end
        git "OuterProject", :url => "git@example.com:outer.git"
      end
    end

    dsl = definition.dsl
    assert_equal 1, dsl.directories.length
    outer_dir = dsl.directories.first

    assert_equal "Outer", outer_dir.path
    assert_equal 1, outer_dir.directories.length

    assert_equal 1, outer_dir.repos.length
    outer_repo = outer_dir.repos.first

    assert_equal "OuterProject", outer_repo.name
    assert_equal "git@example.com:outer.git", outer_repo.url

    inner_dir = outer_dir.directories.first
    assert_equal "Inner", inner_dir.path

    assert_equal 1, inner_dir.repos.length
    inner_repo = inner_dir.repos.first

    assert_equal "InnerProject", inner_repo.name
    assert_equal "git@example.com:inner.git", inner_repo.url
  end

end