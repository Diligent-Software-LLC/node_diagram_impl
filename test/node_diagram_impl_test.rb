require_relative 'test_helper'

# NodeDiagramTest.
# @class_description
#   Tests the NodeDiagram class.
class NodeDiagramTest < Minitest::Test

  # Constants.
  # CLASS       = NodeDiagram
  LONG_SYMBOL = :long_symbol_ch_ch_ch_ah_ah_ah

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   .yardopts, .gitignore, Changelog.md, CODE_OF_CONDUCT.md,
  #   node_diagram_impl.gemspec, Gemfile.lock, and Rakefile files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')
    assert_path_exists('.gitignore')
    assert_path_exists('Changelog.md')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('node_diagram_impl.gemspec')
    assert_path_exists('Gemfile.lock')
    assert_path_exists('Rakefile')

  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(NodeDiagram::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()
  end

  # NodeDiagram.base_label().

  # test_cbl_x().
  # @description
  #   BASE_LABEL.
  def test_cbl_x()

    expected = 'base'.freeze()
    actual   = NodeDiagram.base_label()
    assert_equal(expected, actual)

  end

  # NodeDiagram.data_label().

  # test_cdl_x().
  # @description
  #   DATA_LABEL.
  def test_cdl_x()

    expected = 'data:'.freeze()
    actual   = NodeDiagram.data_label()
    assert_equal(expected, actual)

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
