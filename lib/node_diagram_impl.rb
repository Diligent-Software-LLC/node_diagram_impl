# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "node_diagram_impl/version"

# NodeDiagram.
# @class_description
#   A NodeDiagram library implementation.
# @attr node_string [String]
#   A Node's 'to_s()' String.
# @attr data_text [String]
#   The lower row's data text.
# @attr dl_padding [String]
#   The lower row's left padding.
# @attr dr_padding [String]
#   The lower row's right padding.
# @attr kind [String]
#   The Node kind. Either 'lone', 'base', 'common', or 'pioneer'.
class NodeDiagram < Diagram

  # self.base_label().
  # @description
  #   Gets BASE_LABEL.
  # @return [String]
  #   BASE_LABEL's reference.
  def self.base_label()
    return BASE_LABEL
  end

  # self.data_label().
  # @description
  #   Gets DATA_LABEL.
  # @return [String]
  #   DATA_LABEL's reference.
  def self.data_label()
    return DATA_LABEL
  end

  # self.bl_length().
  # @description
  #   Gets BL_LENGTH.
  # @return [String]
  #   BL_LENGTH's reference.
  def self.bl_length()
    return BL_LENGTH
  end

  # self.cp_length().
  # @description
  #   Gets CP_LENGTH.
  # @return [String]
  #   CP_LENGTH's reference.
  def self.cp_length()
    return CP_LENGTH
  end

  # self.newline().
  # @description
  #   Gets NEWLINE.
  # @return [String]
  #   NEWLINE's reference.
  def self.newline()
    return NEWLINE
  end

  # initialize(n = nil).
  # @description
  #   Initializes a NodeDiagram.
  # @param n [Node]
  #   Any instance.
  # @return [NodeDiagram]
  #   The initialization.
  def initialize(n = nil)

    self.node_string = n.to_s()
    self.data_text   = n.d()
    self.kind        = kind_strategy(n)
    self.dl_padding  = Diagram.space() * dlp_quantity()
    self.dr_padding  = Diagram.space() * drp_quantity()

  end

  # node_string().
  # @description
  #   Gets node_string.
  # @return [String]
  #   The initializing Node's 'to_s()' String.
  def node_string()
    return @node_string
  end

  # data_text().
  # @description
  #   Gets data_text.
  # @return [String]
  #   data_text's reference.
  def data_text()
    return @data_text
  end

  # dl_padding().
  # @description
  #   Gets dl_padding.
  # @return [String]
  #   dl_padding's reference.
  def dl_padding()
    return @dl_padding
  end

  # dr_padding().
  # @description
  #   Gets dr_padding.
  # @return [String]
  #   dr_padding's reference.
  def dr_padding()
    return @dr_padding
  end

  # kind().
  # @description
  #   Gets kind.
  # @return [String]
  #   kind's reference.
  def kind()
    return @kind
  end

  # lower_text(data = nil).
  # @description
  #   Concatenates the lower row text.
  # @param data [DataType]
  #   An instance's data.
  # @return [String]
  #   The lower row text.
  def lower_text(data = nil)
    text = NodeDiagram.data_label() + NodeDiagram.space() + "#{data}"
    return text
  end

  # upper_text().
  # @description
  #   Concatenates the upper row's text.
  # @return [String]
  #   The upper row's text.
  def upper_text()
    if (kind().eql?('base') || kind().eql?('lone'))
      return (NodeDiagram.base_label() + NodeDiagram.space() + node_string())
    else
      return node_string()
    end
  end

  # dlp_quantity().
  # @description
  #   Computes the lower row's left padding quantity.
  # @return [Integer]
  #   The quantity.
  def dlp_quantity()

    quantity  = 0
    dt_length = data_text().length()
    if (kind().eql?('base') || kind().eql?('lone'))
      quantity = (NodeDiagram.bl_length() - dt_length) / 2
    else
      quantity = (NodeDiagram.cp_length() - dt_length) / 2
    end
    return quantity

  end

  # drp_quantity().
  # @description
  #   Computes the lower row's padding quantity.
  # @return [Integer]
  #   The quantity.
  def drp_quantity()

    quantity        = 0
    remaining_space = 0
    dt_length       = data_text().length()
    if (kind().eql?('base') || kind().eql?('lone'))
      remaining_space = NodeDiagram.bl_length() - dt_length
      quantity        = remaining_space / 2
      if (remaining_space.odd?()) then
        quantity += 1
      end
    else
      remaining_space = NodeDiagram.cp_length() - dt_length
      quantity        = remaining_space / 2
      if (remaining_space.odd?()) then
        quantity += 1
      end
    end
    return quantity

  end

  # lower_body().
  # @description
  #   Concatenates the lower row body parts.
  # @return [String]
  #   The lower row's body.
  def lower_body()
    return (dl_padding() + data_text() + dr_padding())
  end

  # row(body = nil).
  # @description
  #   Forms arrow.
  # @param body [String]
  #   A row body.
  # @return [String]
  #   The row.
  def row(body = nil)
    return (NodeDiagram.pipe() + NodeDiagram.space() + body +
        NodeDiagram.space() + NodeDiagram.pipe())
  end

  # kind_strategy(n = nil).
  # @description
  #   Discerns the Node's kind.
  # @param n [Node]
  #   The initializing instance.
  # @return [String]
  #   Either 'lone', 'base', 'common', or 'pioneer'.
  def kind_strategy(n = nil)

    case
    when n.base()
      return 'base'.freeze()
    when n.no_attachments()
      return 'lone'.freeze()
    when n.back_attached() && n.front_attached()
      return 'common'.freeze()
    when n.pioneer()
      return 'pioneer'.freeze()
    end

  end

  # form_lower().
  # @description
  #   Forms the lower row.
  # @return [String]
  #   The formation.
  def form_lower()
    return row(lower_body())
  end

  # form_upper().
  # @description
  #   Forms the upper row.
  # @return [String]
  #   The formation.
  def form_upper()
    return row(upper_text())
  end

  # form().
  # @description
  #   Forms a diagram string.
  # @return [String]
  #   The formation.
  def form()
    return (form_upper() + NEWLINE + form_lower())
  end

  private

  # node_string=(n_str = nil).
  # @description
  #   Sets node_string.
  # @param n_str [String]
  #   A Node's 'to_s()' String.
  # @return [String]
  #   The argument.
  def node_string=(n_str = nil)
    @node_string = n_str
  end

  # data_text=(data = nil).
  # @description
  #   Sets data_text.
  # @param data [String]
  #   A Node's data.
  # @return [String]
  #   The argument.
  def data_text=(data = nil)

    data_string = "#{data}"
    dt_length   = data_string.length()
    case
    when (kind().eql?('base') || kind().eql?('lone')) &&
        dt_length > 25
      @data_text = lower_text(data_string.slice(0, 25))
    when (kind().eql?('common') || kind().eql?('pioneer')) &&
        dt_length > 20
      @data_text = lower_text(data_string.slice(0, 20))
    else
      @data_text = lower_text(data)
    end

  end

  # dl_padding=(padding = '').
  # @description
  #   Sets dl_padding.
  # @param padding [String]
  #   Padding space.
  # @return [String]
  #   The argument.
  def dl_padding=(padding = '')
    @dl_padding = padding
  end

  # dr_padding=(padding = '').
  # @description
  #   Sets dr_padding.
  # @param padding [String]
  #   Padding space.
  # @return [String]
  #   The argument.
  def dr_padding=(padding = '')
    @dr_padding = padding
  end

  # kind=(n_k = nil).
  # @description
  #   Sets kind.
  # @param n_k [String]
  #   Either 'lone', 'base', 'common', or 'pioneer'.
  # @return [String]
  #   The argument.
  def kind=(n_k = nil)
    @kind = n_k
  end

  # Private constants.
  BASE_LABEL = 'base'.freeze()
  DATA_LABEL = 'data:'.freeze()
  BL_LENGTH  = 31 # base, lone body length.
  CP_LENGTH  = 26 # common, pioneer body length.
  NEWLINE    = "\n".freeze()
  private_constant :BASE_LABEL
  private_constant :DATA_LABEL
  private_constant :BL_LENGTH
  private_constant :CP_LENGTH
  private_constant :NEWLINE

end
