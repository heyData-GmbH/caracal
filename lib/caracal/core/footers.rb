require 'caracal/core/models/footer_model'
require 'caracal/errors'


module Caracal
  module Core

    # This module encapsulates all the functionality related to adding a page
    # footer to the document.
    module Footers
      def self.included(base)
        base.class_eval do

          #-------------------------------------------------------------
          # Configuration
          #-------------------------------------------------------------

          attr_reader :footer_show
          attr_reader :footer_contents
          attr_reader :footer_relationships

          def footer_relationships
            @footer_relationships ||= []
          end

          def footer_relationships=(relationships)
            @footer_relationships = relationships
          end

          #-------------------------------------------------------------
          # Public Methods
          #-------------------------------------------------------------

          # This method controls whether and how page footers are displayed
          # on the document.
          def footer(*args, &block)
            options = Caracal::Utilities.extract_options!(args)
            options.merge!({ show: !!args.first }) unless args.first.nil?  # careful: falsey value

            # copy page settings so TableModel can calculate width properly
            options[:width] = page_width
            options[:margin_left] = page_margin_left
            options[:margin_right] = page_margin_right

            model = Caracal::Core::Models::FooterModel.new(options, &block)
            if model.valid?
              @footer_show     = model.footer_show
              @footer_contents = model.contents
            else
              @footer_show = false
            end
            model
          end
        end
      end
    end
  end
end
