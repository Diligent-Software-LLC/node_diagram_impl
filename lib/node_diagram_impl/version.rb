# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

#require 'diagram_comp'

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
class NodeDiagram #< Diagram
  VERSION = '1.0.0'.freeze()
end
