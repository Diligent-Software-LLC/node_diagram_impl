require_relative 'test_helper'

# NodeDiagramTest.
# @class_description
#   Tests the NodeDiagram class.
class NodeDiagramTest < Minitest::Test

  # Constants
  CLASS       = NodeDiagram
  LONG_SYMBOL = :long_symbol_ch_ch_ch_ah_ah_ah

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   and .yardopts files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')

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
    @node1 = Node.new(nil, nil, nil)
    @node2 = Node.new(nil, :test_symbol, nil)
  end

  # NodeDiagram.base_label()

  # test_cbl_x().
  # @description
  #   BASE_LABEL.
  def test_cbl_x()

    expected = 'base'.freeze()
    actual   = NodeDiagram.base_label()
    assert_equal(expected, actual)

  end

  # NodeDiagram.data_label()

  # test_cdl_x().
  # @description
  #   DATA_LABEL.
  def test_cdl_x()

    expected = 'data:'.freeze()
    actual   = NodeDiagram.data_label()
    assert_equal(expected, actual)

  end

  # initialize(n = nil)

  # test_init_x1().
  # @description
  #   A base or lone Node.
  def test_init_x1()

    diagram_inst = NodeDiagram.new(@node1)
    assert_same(CLASS, diagram_inst.class())
    expected_n_str = @node1.to_s()
    assert_equal(expected_n_str, diagram_inst.node_string())
    expected_dt = "data: #{@node1.d()}"
    actual_dt   = diagram_inst.data_text()
    assert_equal(expected_dt, actual_dt)
    expected_dlp = ' ' * 12
    actual_dlp   = diagram_inst.dl_padding()
    assert_equal(expected_dlp, actual_dlp)
    expected_drp = ' ' * 13
    actual_drp   = diagram_inst.dr_padding()
    assert_equal(expected_drp, actual_drp)
    expected_kind = 'lone'.freeze()
    actual_kind   = diagram_inst.kind()
    assert_equal(expected_kind, actual_kind)

  end

  # test_init_x2().
  # @description
  #   A common or pioneer Node.
  def test_init_x2()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node2.to_s())
    common.expect(:d, :test_symbol)
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    diagram_inst = NodeDiagram.new(common)
    assert_same(CLASS, diagram_inst.class())
    expected_ns = @node2.to_s()
    actual_ns   = diagram_inst.node_string()
    assert_equal(expected_ns, actual_ns)
    expected_dt = "data: #{@node2.d()}"
    actual_dt   = diagram_inst.data_text()
    assert_equal(expected_dt, actual_dt)
    expected_dlp = ' ' * 4
    actual_dlp   = diagram_inst.dl_padding()
    assert_equal(expected_dlp, actual_dlp)
    expected_drp = ' ' * 5
    actual_drp   = diagram_inst.dr_padding()
    assert_equal(expected_drp, actual_drp)
    expected_kind = 'common'
    actual_kind   = diagram_inst.kind()
    assert_equal(expected_kind, actual_kind)

  end

  # node_string()

  # test_ns_x().
  # @description
  #   @node_string is the initializing Node's 'to_s()' String.
  def test_ns_x()

    d_inst   = NodeDiagram.new(@node1)
    expected = @node1.to_s()
    actual   = d_inst.node_string()
    assert_equal(expected, actual)

  end

  # data_text()

  # test_dt_x().
  # @description
  #   data_text is the data label, a space, and the data, concatenated.
  def test_dt_x()

    d_inst   = NodeDiagram.new(@node2)
    expected = "data: #{@node2.d()}"
    actual   = d_inst.data_text()
    assert_equal(expected, actual)

  end

  # dl_padding()

  # test_dlp_x().
  # @description
  #   dl_padding is a String.
  def test_dlp_x()

    d_inst   = NodeDiagram.new(@node1)
    expected = String
    actual   = d_inst.dl_padding()
    actual   = actual.class()
    assert_same(expected, actual)

  end

  # dr_padding()

  # test_drp_x().
  # @description
  #   dr_padding is a String.
  def test_drp_x()

    d_inst   = NodeDiagram.new(@node1)
    expected = String
    actual   = d_inst.dr_padding()
    actual   = actual.class()
    assert_same(expected, actual)

  end

  # kind()

  # test_kind_x().
  # @description
  #   kind is a String and either 'lone', 'base', 'common', or 'pioneer'.
  def test_kind_x()

    kind_set = Set['base'.freeze(), 'lone'.freeze(), 'common'.freeze(),
                   'pioneer'.freeze()]
    d_inst   = NodeDiagram.new(@node1)
    assert_includes(kind_set, d_inst.kind())

  end

  # lower_text()

  # test_lt_x().
  # @description
  #   The return is the data label, a space, and the data concatenated.
  def test_lt_x()

    d_inst   = NodeDiagram.new(@node1)
    expected = "data: ".freeze()
    actual   = d_inst.lower_text(@node1.d())
    assert_equal(expected, actual)

  end

  # upper_text()

  # test_ut_x1().
  # @description
  #   A base or lone Node.
  def test_ut_x1()

    d_inst   = NodeDiagram.new(@node1)
    expected = "base #{@node1.to_s()}"
    actual   = d_inst.upper_text()
    assert_equal(expected, actual)

  end

  # test_ut_x2().
  # @description
  #   A common or pioneer Node.
  def test_ut_x2()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node1.to_s())
    common.expect(:d, nil)
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = "#{@node1}".freeze()
    actual   = d_inst.upper_text()
    assert_equal(expected, actual)

  end

  # dlp_quantity()

  # test_dlpq_x1().
  # @description
  #   The initializing Node's data is nil and the Node is a 'common' or
  #   'pioneer' Node.
  def test_dlpq_x1()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node1.to_s())
    common.expect(:d, nil)
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = 10
    actual   = d_inst.dlp_quantity()
    assert_equal(expected, actual)

  end

  # test_dlpq_x2().
  # @description
  #   The initializing Node's data length is 20 and the Node is a 'common' or
  #   'pioneer' Node.
  def test_dlpq_x2()

    pioneer = Minitest::Mock.new()
    pioneer.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    pioneer.expect(:d, sym_str.slice(0, 20))
    pioneer.expect(:base, false)
    pioneer.expect(:no_attachments, false)
    pioneer.expect(:back_attached, false)
    pioneer.expect(:pioneer, true)
    d_inst   = NodeDiagram.new(pioneer)
    expected = 0
    actual   = d_inst.dlp_quantity()
    assert_equal(expected, actual)

  end

  # test_dlpq_x3().
  # @description
  #   The initialization Node's data length is greater than 20 and the Node
  #   is a common Node or pioneer Node.
  def test_dlpq_x3()

    pioneer = Minitest::Mock.new()
    pioneer.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    pioneer.expect(:d, sym_str.slice(0, 20))
    pioneer.expect(:base, false)
    pioneer.expect(:no_attachments, false)
    pioneer.expect(:back_attached, false)
    pioneer.expect(:pioneer, true)
    d_inst   = NodeDiagram.new(pioneer)
    expected = 0
    actual   = d_inst.dlp_quantity()
    assert_equal(expected, actual)

  end

  # test_dlpq_x4().
  # @description
  #   The initialization Node's data length is greater than 0 and less than
  #   20, and the Node is a common Node or a pioneer Node.
  def test_dlpq_x4()

    pioneer = Minitest::Mock.new()
    pioneer.expect(:to_s, @node1.to_s())
    pioneer.expect(:d, true)
    pioneer.expect(:base, false)
    pioneer.expect(:no_attachments, false)
    pioneer.expect(:back_attached, false)
    pioneer.expect(:pioneer, true)
    d_inst   = NodeDiagram.new(pioneer)
    expected = ' ' * 8
    actual   = d_inst.dl_padding()
    assert_equal(expected, actual)

  end

  # test_dlpq_x5().
  # @description
  #   The initializing Node's data is nil, and the Node's kind is base or lone.
  def test_dlpq_x5()

    lone = Minitest::Mock.new()
    lone.expect(:to_s, @node1.to_s())
    lone.expect(:d, nil)
    lone.expect(:base, false)
    lone.expect(:no_attachments, true)
    d_inst   = NodeDiagram.new(lone)
    expected = ' ' * 12
    actual   = d_inst.dl_padding()
    assert_equal(expected, actual)

  end

  # test_dlpq_x6().
  # @description
  #   The initializing Node's data length is 25, and the Node's kind is base
  #   or lone.
  def test_dlpq_x6()

    lone = Minitest::Mock.new()
    lone.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    lone.expect(:d, sym_str.slice(0, 25))
    lone.expect(:base, false)
    lone.expect(:no_attachments, true)
    d_inst   = NodeDiagram.new(lone)
    expected = ''
    actual   = d_inst.dl_padding()
    assert_equal(expected, actual)

  end

  # test_dlpq_x7().
  # @description
  #   The initializing Node's data length is greater than 25, and the Node's
  #   kind is base or lone.
  def test_dlpq_x7()

    lone = Minitest::Mock.new()
    lone.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    lone.expect(:d, sym_str.slice(0, 25))
    lone.expect(:base, false)
    lone.expect(:no_attachments, true)
    d_inst   = NodeDiagram.new(lone)
    expected = ''
    actual   = d_inst.dl_padding()
    assert_equal(expected, actual)

  end

  # test_dlpq_x8().
  # @description
  #   The initialization Node's data length is greater than 0 and less than
  #   25. The Node's kind is lone or base.
  def test_dlpq_x8()

    lone = Minitest::Mock.new()
    lone.expect(:to_s, @node1.to_s())
    lone.expect(:d, false)
    lone.expect(:base, false)
    lone.expect(:no_attachments, true)
    d_inst   = NodeDiagram.new(lone)
    expected = ' ' * 10
    actual   = d_inst.dl_padding()
    assert_equal(expected, actual)

  end

  # drp_quantity()

  # test_drpq_x1().
  # @description
  #   The initializing Node's data is nil, and the Node's kind is 'common' or
  #   'pioneer'.
  def test_drpq_x1()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node1.to_s())
    common.expect(:d, nil)
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = ' ' * 10
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x2().
  # @description
  #   The initialization node's data length is 20, and the Node's kind is
  #   'common' or 'pioneer'.
  def test_drpq_x2()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    common.expect(:d, sym_str.slice(0, 20))
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = ''.freeze()
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x3().
  # @description
  #   The initialization Node's data length is greater than 20, and the
  #   Node's kind is either 'common' or 'pioneer'.
  def test_drpq_x3()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    common.expect(:d, sym_str.slice(0, 20))
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = ''.freeze()
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x4().
  # @description
  #   The initialization Node's data length is less than 20 and greater than
  #   0. The Node's kind is either 'common' or 'pioneer'.
  def test_drpq_x4()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node1.to_s())
    common.expect(:d, false)
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = ' ' * 8
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x5().
  # @description
  #   The initialization Node's data is nil, and the Node's kind is base or
  #   lone.
  def test_drpq_x5()

    base = Minitest::Mock.new()
    base.expect(:to_s, @node1.to_s())
    base.expect(:d, nil)
    base.expect(:base, true)
    d_inst   = NodeDiagram.new(base)
    expected = ' ' * 13
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x6().
  # @description
  #   The initialization Node's data length is 25. The Node's kind is either
  # 'base' or 'lone'.
  def test_drpq_x6()

    base = Minitest::Mock.new()
    base.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    base.expect(:d, sym_str.slice(0, 25))
    base.expect(:base, true)
    d_inst   = NodeDiagram.new(base)
    expected = ''.freeze()
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x7().
  # @description
  #   The initialization Node's data length is greater than 25. The Node's
  #   kind is either 'base' or 'lone'.
  def test_drpq_x7()

    base = Minitest::Mock.new()
    base.expect(:to_s, @node1.to_s())
    sym_str = "#{LONG_SYMBOL}"
    base.expect(:d, sym_str.slice(0, 25))
    base.expect(:base, true)
    d_inst   = NodeDiagram.new(base)
    expected = ''.freeze()
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # test_drpq_x8().
  # @description
  #   The initialization Node's data is greater than 0 and less than 25. The
  #   Node's kind is either 'base' or 'lone'.
  def test_drpq_x8()

    base = Minitest::Mock.new()
    base.expect(:to_s, @node1.to_s())
    base.expect(:d, :test_symbol)
    base.expect(:base, true)
    d_inst   = NodeDiagram.new(base)
    expected = ' ' * 7
    actual   = d_inst.dr_padding()
    assert_equal(expected, actual)

  end

  # lower_body()

  # test_lb_x().
  # @description
  #   The data label, space character, and data concatenated.
  def test_lb_x()

    d_inst   = NodeDiagram.new(@node2)
    expected = d_inst.dl_padding() + NodeDiagram.data_label() +
        NodeDiagram.space() + "#{@node2.d()}" + d_inst.dr_padding()
    actual   = d_inst.lower_body()
    assert_equal(expected, actual)

  end

  # row()

  # test_row_x1().
  # @description
  #   The lower row.
  def test_row_x1()

    d_inst   = NodeDiagram.new(@node2)
    expected = '|        data: test_symbol        |'.freeze()
    actual   = d_inst.row(d_inst.lower_body())
    assert_equal(expected, actual)

  end

  # test_row_x2().
  # @description
  #   The upper row.
  def test_row_x2()

    d_inst   = NodeDiagram.new(@node2)
    expected = "| base #{@node2.to_s()} |".freeze()
    actual   = d_inst.row(d_inst.upper_text())
    assert_equal(expected, actual)

  end

  # kind_strategy()

  # test_ks_x1().
  # @description
  #   A 'lone' Node.
  def test_ks_x1()

    lone = Minitest::Mock.new()
    lone.expect(:d, :test_symbol)
    lone.expect(:base, false)
    lone.expect(:no_attachments, true)
    d_inst   = NodeDiagram.new(lone)
    expected = 'lone'.freeze()
    lone.expect(:base, false)
    lone.expect(:no_attachments, true)
    actual = d_inst.kind_strategy(lone)
    assert_equal(expected, actual)

  end

  # test_ks_x2().
  # @description
  #   A 'base' Node.
  def test_ks_x2()

    base = Minitest::Mock.new()
    base.expect(:to_s, @node2.to_s())
    base.expect(:d, :test_symbol)
    base.expect(:base, true)
    base.expect(:base, true)
    d_inst   = NodeDiagram.new(base)
    expected = 'base'.freeze()
    actual   = d_inst.kind_strategy(base)
    assert_equal(expected, actual)

  end

  # test_ks_x3().
  # @description
  #   A 'common' Node.
  def test_ks_x3()

    common = Minitest::Mock.new()
    common.expect(:to_s, @node2.to_s())
    common.expect(:d, :test_symbol)
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    d_inst   = NodeDiagram.new(common)
    expected = 'common'.freeze()
    common.expect(:base, false)
    common.expect(:no_attachments, false)
    common.expect(:back_attached, true)
    common.expect(:front_attached, true)
    actual = d_inst.kind_strategy(common)
    assert_equal(expected, actual)

  end

  # test_ks_x4().
  # @description
  #   A 'pioneer' Node.
  def test_ks_x4()

    pioneer = Minitest::Mock.new()
    pioneer.expect(:to_s, @node2.to_s())
    pioneer.expect(:d, :test_symbol)
    pioneer.expect(:base, false)
    pioneer.expect(:no_attachments, false)
    pioneer.expect(:back_attached, false)
    pioneer.expect(:pioneer, true)
    d_inst   = NodeDiagram.new(pioneer)
    expected = 'pioneer'.freeze()
    pioneer.expect(:base, false)
    pioneer.expect(:no_attachments, false)
    pioneer.expect(:back_attached, false)
    pioneer.expect(:pioneer, true)
    actual = d_inst.kind_strategy(pioneer)
    assert_equal(expected, actual)

  end

  # form_lower()

  # test_fl_x().
  # @description
  #   The lower body between pipes and spaces.
  def test_fl_x()

    d_inst   = NodeDiagram.new(@node2)
    expected = "| " + d_inst.lower_body() + " |"
    actual   = d_inst.form_lower()
    assert_equal(expected, actual)

  end

  # form_upper()

  # test_fu_x().
  # @description
  #   The upper body.
  def test_fu_x()

    d_inst   = NodeDiagram.new(@node2)
    expected = "base #{d_inst.node_string()}"
    actual   = d_inst.upper_text()
    assert_equal(expected, actual)

  end

  # form()

  # test_form_x().
  # @description
  #   The upper row, a newline character, and the lower row, concatenated.
  def test_form_x()

    d_inst   = NodeDiagram.new(@node2)
    expected = d_inst.form_upper() + NodeDiagram.newline() + d_inst.form_lower()
    actual   = d_inst.form()
    assert_equal(expected, actual)

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()
  end

end
