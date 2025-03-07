# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/rgeo"
require "psych"
require_relative "common/factory_tests"
require_relative "common/geometry_collection_tests"
require_relative "common/line_string_tests"
require_relative "common/multi_line_string_tests"
require_relative "common/multi_point_tests"
require_relative "common/multi_polygon_tests"
require_relative "common/point_tests"
require_relative "common/polygon_tests"

require "pry-byebug" if ENV["BYEBUG"]

# Static test for missed references in our CAPI codebase (or FFI interface).
# See https://alanwu.space/post/check-compaction/
if defined?(GC.verify_compaction_references) == "method"
  GC.verify_compaction_references(double_heap: true, toward: :empty)
end

# Live test for our implementation of Ruby's compaction methods (rb_gc_mark_movable
# and rb_gc_location), enabling compaction for every major collection.
if defined?(GC.auto_compact) == "method"
  GC.auto_compact = true
end
